
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:porcelain/product/add_product_dialog.dart';
import 'package:porcelain/product/product.dart';

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
      title: 'Porcelain',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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

  Future<void> addProduct() async {
    Product newProduct = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddProductDialog()));
    var box = Hive.box<Product>('productBox');
    box.add(newProduct);
    setState(() {

    });
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

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: const Text("Your Products"),
      ),
      body: ListView.builder(
        itemCount: box.length,
        itemBuilder: (context, index) {
          return makeProductCard(box.getAt(index)!);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addProduct,
        tooltip: 'Add Product',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Card makeProductCard(Product product) {
  return Card(
    elevation: 4,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Icon(Icons.clean_hands),
          title: Text(product.name),
          subtitle: Text(product.purpose),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.monthsToReplacement != null)
                Text('Months to Replacement: ${product.monthsToReplacement}'),
              Text('Replace: ${product.replace ? "Yes" : "No"}'),
            ],
          ),
        ),
      ],
    ),
  );
}
