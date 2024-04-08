import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shelflife/colors.dart';
import 'package:shelflife/constants.dart';
import 'package:shelflife/notification/notification_service.dart';
import 'package:shelflife/product/add_product_dialog.dart';
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

  if (!(await Permission.notification.status.isGranted)) {
    PermissionStatus status = await Permission.notification.request();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shelf Life',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: JAR_BLUE),
      home: const ProductsPage(),
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

  void setNotification(Product product, bool isNew) {
    if (!isNew) {
      notificationService.deleteNotification(product.productId);
    }
    String timeString = settingsBox.get(HIVE_NOTIFICATION_TIME_KEY, defaultValue: Utils.timeOfDayToString(DEFAULT_NOTIFICATION_TIME));
    TimeOfDay time = Utils.stringToTimeOfDay(timeString);
    if (product.monthsToReplacement != null) {
      DateTime notificationDate = DateTime.fromMillisecondsSinceEpoch(product.saveTime).add(Duration(days: product.monthsToReplacement! * 30));
      notificationService.showScheduledNotification(
          id: product.productId,
          title: "${product.name} reaching the end of its shelf life",
          body: "To extend its shelf-life, open the app to reset.",
          date: notificationDate.copyWith(hour: time.hour, minute: time.minute, second: 0));
    }
  }

  void resetNotifications() {
    for (Product product in productBox.values) {
      if (product.monthsToReplacement != null) {
        setNotification(product, false);
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
    productBox.delete(product.key);
    notificationService.deleteNotification(product.productId);
    setState(() {});
  }

  void _showTagMultiSelect(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog<Tag>(
          title: Text(tagBox.values.isEmpty ? "No Tags Created" : "Filter by Tags"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: JAR_BLUE,
        title: const Text(
          "Your Products",
        ),
        actions: [
          IconButton(
              onPressed: () => _showTagMultiSelect(context),
              icon: const Icon(
                Icons.filter_list,
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
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'Tags',
                  child: Text('Manage Tags'),
                ),
                const PopupMenuItem(
                  value: 'Settings',
                  child: Text('Settings'),
                ),
              ];
            },
          ),
        ],
      ),
      body: ReorderableListView.builder(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => addProduct(),
        tooltip: 'Add Product',
        child: const Icon(
          Icons.add,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
