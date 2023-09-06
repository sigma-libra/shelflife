import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shelflife/colors.dart';
import 'package:shelflife/product/add_product_dialog.dart';
import 'package:shelflife/product/product.dart';
import 'package:shelflife/product/product_card.dart';
import 'package:shelflife/tag/tag.dart';
import 'package:shelflife/tag/tags_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(TagAdapter());
  await Hive.openBox<Product>('productBox');
  await Hive.openBox<Tag>("tagBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shelf Life',
      theme: ThemeData(
        scaffoldBackgroundColor: WALL_BLUE,
        colorScheme: ColorScheme.fromSeed(seedColor: ORANGE),
        useMaterial3: true,
      ),
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
  var productBox = Hive.box<Product>('productBox');
  var tagBox = Hive.box<Tag>("tagBox");
  var filterTags = List<String>.empty();

  @override
  void initState() {
    productBox = Hive.box<Product>('productBox');
    tagBox = Hive.box<Tag>("tagBox");
    filterTags = List<String>.empty();
    super.initState();
  }

  Future<void> addProduct(int productKey) async {
    List<Tag> tags = tagBox.values.toList();
    Product newProduct = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddProductDialog(
                  tags: tags,
                )));
    productBox.put(productKey, newProduct);
    setState(() {});
  }

  Future<void> editProduct(Product product) async {
    List<Tag> tags = tagBox.values.toList();
    Product newProduct = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddProductDialog(
                  product: product,
                  tags: tags,
                )));
    productBox.put(product.key, newProduct);
    setState(() {});
  }

  void deleteProduct(Product product) {
    productBox.delete(product.key);
    setState(() {});
  }

  void confirmTagFilter(List<Tag> newFilterTags) {
    setState(() {
      filterTags = newFilterTags.map((e) => e.name).toList();
    });
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
        backgroundColor: DARK_BROWN,
        title: const Text(
          "Your Products",
          style: TextStyle(color: ORANGE),
        ),
        actions: [
          MultiSelectDialogField<Tag>(
            items: tagBox.values.map((e) => MultiSelectItem(e, e.name)).toList(),
            onConfirm: confirmTagFilter,
            chipDisplay: MultiSelectChipDisplay.none(),
          ),
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
                // Handle the "Settings" option
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'Tags',
                  child: Text('Tags'),
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
              tags: tagBox.values.toList(),
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
        backgroundColor: ORANGE,
        onPressed: () => addProduct(productBox.length),
        tooltip: 'Add Product',
        child: const Icon(
          Icons.add,
          color: DARK_BROWN,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
