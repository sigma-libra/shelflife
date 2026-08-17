import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shelflife/colors.dart';
import 'package:shelflife/constants.dart';
import 'package:shelflife/l10n/app_localizations.dart';
import 'package:shelflife/notification/notification_service.dart';
import 'package:shelflife/product/add_product_dialog.dart';
import 'package:shelflife/product/empty_shelf.dart';
import 'package:shelflife/product/product.dart';
import 'package:shelflife/product/product_card.dart';
import 'package:shelflife/settings/settings_page.dart';
import 'package:shelflife/tag/tag.dart';
import 'package:shelflife/tag/tags_page.dart';
import 'package:shelflife/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(TagAdapter());
  await Hive.openBox<Product>(HIVE_PRODUCT_BOX);
  await Hive.openBox<Tag>(HIVE_TAG_BOX);
  await Hive.openBox(HIVE_SETTINGS_BOX);

  // Notification permission is asked for later, in context, the first time a
  // product actually needs a reminder scheduled — not here, blind, before the
  // user has seen the app at all.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: JAR_BLUE),
      home: const ProductsPage(),
      builder: (context, child) {
        return Title(
          title: AppLocalizations.of(context)!.appTitle,
          color: Colors.black,
          child: child!,
        );
      },
    );
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late Box<Product> productBox;
  late Box<Tag> tagBox;
  late Box settingsBox;
  late List<String> filterTags;
  late String textFilter;
  late NotificationService notificationService;

  @override
  void initState() {
    productBox = Hive.box<Product>(HIVE_PRODUCT_BOX);
    tagBox = Hive.box<Tag>(HIVE_TAG_BOX);
    settingsBox = Hive.box(HIVE_SETTINGS_BOX);
    filterTags = List<String>.empty();
    textFilter = "";
    notificationService = NotificationService();
    notificationService.init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    notificationService.setChannelLocalization(
      AppLocalizations.of(context)!.notificationChannelName,
      AppLocalizations.of(context)!.notificationChannelDescription,
    );
  }

  Future<void> setNotification(Product product, bool isNew) async {
    if (!isNew) {
      notificationService.deleteNotification(product.productId);
    }
    if (product.monthsToReplacement == null) {
      return;
    }

    // The first product to actually want a reminder is the point of asking —
    // the user just told us they care about this feature, so the OS dialog
    // has context instead of appearing over a blank cold-start screen.
    if (!(await Permission.notification.status.isGranted)) {
      await Permission.notification.request();
    }
    // The permission dialog is an async gap: the page (and its context) may
    // have been disposed while the user was looking at it.
    if (!mounted) {
      return;
    }

    String timeString = settingsBox.get(HIVE_NOTIFICATION_TIME_KEY, defaultValue: Utils.timeOfDayToString(DEFAULT_NOTIFICATION_TIME));
    TimeOfDay time = Utils.stringToTimeOfDay(timeString);
    DateTime notificationDate = DateTime.fromMillisecondsSinceEpoch(product.saveTime).add(Duration(days: product.monthsToReplacement! * 30));
    notificationService.showScheduledNotification(
        id: product.productId,
        title: AppLocalizations.of(context)!.notificationTitle(product.name),
        body: AppLocalizations.of(context)!.notificationBody,
        date: notificationDate.copyWith(hour: time.hour, minute: time.minute, second: 0));
  }

  Future<void> resetNotifications() async {
    for (Product product in productBox.values) {
      if (product.monthsToReplacement != null) {
        try {
          await setNotification(product, false);
        } catch (e) {
          // One bad reschedule (e.g. a timezone lookup failure) shouldn't
          // silently drop the reminder for every other product in the list.
          debugPrint('Failed to reschedule notification for ${product.name}: $e');
        }
      }
    }
  }

  Future<void> addProduct() async {
    Product newProduct = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddProductDialog(
                  tagBox: tagBox,
                  currencySymbol: settingsBox.get(HIVE_CURRENCY_KEY, defaultValue: DEFAULT_CURRENCY),
                )));

    setState(() {
      productBox.put(newProduct.productId, newProduct);
      setNotification(newProduct, true);
    });
  }

  Future<void> duplicateProduct(Product product) async {
    Product newProduct = Product(
        productId: Utils.randomId(),
        name: product.name,
        saveTime: DateTime.now().millisecondsSinceEpoch,
        monthsToReplacement: product.monthsToReplacement,
        purpose: product.purpose,
        replace: product.replace,
        price: product.price,
        tags: product.tags);

    setState(() {
      productBox.put(newProduct.productId, newProduct);
      setNotification(newProduct, true);
    });
  }

  Future<void> editProduct(Product product) async {
    Product newProduct = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddProductDialog(
                  product: product,
                  tagBox: tagBox,
                  currencySymbol: settingsBox.get(HIVE_CURRENCY_KEY, defaultValue: DEFAULT_CURRENCY),
                )));
    setState(() {
      productBox.put(product.key, newProduct);
      setNotification(newProduct, false);
    });
  }

  void deleteProduct(Product product) {
    // Hold everything needed to put it back. This is the only copy of the
    // user's data, so an accidental swipe has to be recoverable.
    final key = product.key;
    final restored = Product(
        productId: product.productId,
        name: product.name,
        saveTime: product.saveTime,
        monthsToReplacement: product.monthsToReplacement,
        purpose: product.purpose,
        replace: product.replace,
        price: product.price,
        tags: product.tags);

    productBox.delete(key);
    notificationService.deleteNotification(product.productId);
    setState(() {});

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.productDeleted(restored.name)),
        action: SnackBarAction(
          label: AppLocalizations.of(context)!.undo,
          onPressed: () {
            setState(() {
              productBox.put(key, restored);
              setNotification(restored, true);
            });
          },
        ),
      ));
  }

  void _showTagMultiSelect(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog<Tag>(
          title: Text(tagBox.values.isEmpty ? AppLocalizations.of(context)!.noTagsCreated : AppLocalizations.of(context)!.filterByTags),
          items: tagBox.values.map((e) => MultiSelectItem(e, e.name)).toList(),
          initialValue: tagBox.values.where((e) => filterTags.contains(e.name)).toList(),
          colorator: (tag) => Color(tag.color),
          onConfirm: (newFilterTags) => {
            setState(() {
              filterTags = newFilterTags.map((e) => e.name).toList();
            })
          },
        );
      },
    );
  }

  @override
  void dispose() {
    productBox.close();
    tagBox.close();
    super.dispose();
  }

  PreferredSizeWidget _activeFilterBar() {
    // AppBar.bottom needs its height up front, so this can't wrap content the
    // way a normal widget would — instead the base 52dp scales with the
    // system font-size setting (the same clamp JarGauge uses) so the chip row
    // and Clear Filter button have room to grow instead of being cropped.
    final double barHeight = MediaQuery.textScalerOf(context).scale(52).clamp(52, 52 * 1.6);
    return PreferredSize(
      preferredSize: Size.fromHeight(barHeight),
      child: Container(
        height: barHeight,
        color: JAR_BLUE,
        child: Row(
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                children: [
                  for (final tag in filterTags)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Chip(
                        label: Text(tag),
                        onDeleted: () => setState(() {
                          filterTags = List<String>.from(filterTags)..remove(tag);
                        }),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => setState(() => filterTags = List<String>.empty()),
              child: Text(AppLocalizations.of(context)!.clearFilter),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: JAR_BLUE,
        title: Text(
          AppLocalizations.of(context)!.yourProducts,
        ),
        // A filtered list looks exactly like a short list, so the control says
        // how many tags are active and the bar below says which.
        bottom: filterTags.isEmpty ? null : _activeFilterBar(),
        actions: [
          IconButton(
              onPressed: () => _showTagMultiSelect(context),
              tooltip: AppLocalizations.of(context)!.filterByTags,
              icon: Badge(
                isLabelVisible: filterTags.isNotEmpty,
                label: Text('${filterTags.length}'),
                child: const Icon(
                  Icons.filter_list,
                ),
              )),
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'Tags') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TagsPage(
                      tagsBox: tagBox,
                    ),
                  ),
                );
              } else if (value == 'Settings') {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(settingsBox: settingsBox)))
                    .then((value) => resetNotifications());
              } else if (value == "Test Alert") {
                notificationService.showNotification(id: 1000, title: "Test", body: "Testing");
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'Tags',
                  child: Text(AppLocalizations.of(context)!.manageTags),
                ),
                PopupMenuItem(
                  value: 'Settings',
                  child: Text(AppLocalizations.of(context)!.settings),
                ),
                //PopupMenuItem(
                //  value: "Test Alert",
                //  child: Text(AppLocalizations.of(context)!.testAlert),
                //),
              ];
            },
          ),
        ],
      ),
      body: productBox.isEmpty
          ? const EmptyShelf()
          : ReorderableListView.builder(
              itemCount: productBox.length,
              itemBuilder: (context, index) {
                Product product = productBox.getAt(index)!;
                return Visibility(
                  key: Key('$index'),
                  visible: filterTags.isEmpty || product.tags.any((tag) => filterTags.contains(tag)),
                  child: ProductCard(
                    product: product,
                    onDelete: () => deleteProduct(product),
                    onEdit: () => editProduct(product),
                    onDuplicate: () => duplicateProduct(product),
                    tags: tagBox.values.toList(),
                    currencySymbol: settingsBox.get(HIVE_CURRENCY_KEY, defaultValue: DEFAULT_CURRENCY),
                  ),
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  var productList = productBox.values.toList();
                  Product movedProduct = productList.removeAt(oldIndex);
                  productList.insert(newIndex, movedProduct);
                  for (var i = 0; i < productList.length; i++) {
                    productBox.delete(productList[i].key);
                    productBox.put(i, productList[i]);
                  }
                });
              },
            ),
      // Explicitly the scheme's primary rather than the generated container
      // tint, which sat at 1.23:1 against the scaffold and read as a ghost.
      floatingActionButton: FloatingActionButton(
        onPressed: () => addProduct(),
        tooltip: AppLocalizations.of(context)!.addProduct,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        child: const Icon(
          Icons.add,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
