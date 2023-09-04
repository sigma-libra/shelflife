import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shelflife/colors.dart';
import 'package:shelflife/product/add_product_dialog.dart';
import 'package:shelflife/product/product.dart';
import 'package:shelflife/product_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter()); // Register the Product adapter
  await Hive.openBox<Product>('productBox');
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
  Future<void> addProduct(int productKey) async {
    Product newProduct = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductDialog()));
    var box = Hive.box<Product>('productBox');
    box.put(productKey, newProduct);
    setState(() {});
  }

  Future<void> editProduct(Product product) async {
    Product newProduct = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddProductDialog(
                  product: product,
                )));
    var box = Hive.box<Product>('productBox');
    box.put(product.key, newProduct);
    setState(() {});
  }

  void deleteProduct(Product product) {
    var box = Hive.box<Product>('productBox');
    box.delete(product.key);
    setState(() {});
  }

  @override
  void dispose() {
    Hive.box<Product>('productBox').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<Product>('productBox');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: DARK_BROWN,
        title: const Text(
          "Your Products",
          style: TextStyle(color: ORANGE),
        ),
      ),
      body: ReorderableListView.builder(
        itemCount: box.length,
        itemBuilder: (context, index) {
          Product product = box.getAt(index)!;
          return ProductCard(
            key: Key('$index'),
            product: product,
            onDelete: () => deleteProduct(product),
            onEdit: () => editProduct(product),
          );
        },
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            var productList = box.values.toList();
            Product movedProduct = productList.removeAt(oldIndex);
            productList.insert(newIndex, movedProduct);
            box.deleteAll(box.keys);
            for (var i = 0; i < productList.length; i++) {
              box.put(i, productList[i]);
            }
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ORANGE,
        onPressed: () => addProduct(box.length),
        tooltip: 'Add Product',
        child: const Icon(
          Icons.add,
          color: DARK_BROWN,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
