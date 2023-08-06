import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:porcelain/product/product.dart';

class AddProductDialog extends StatelessWidget {

  const AddProductDialog({super.key});


  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController purposeController = TextEditingController();
    return AlertDialog(
      title: const Text('Add New Product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Product Name'),
          ),
          TextField(
            controller: purposeController,
            decoration: const InputDecoration(labelText: 'Product Purpose'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Create a new product object with the user input
            Product newProduct = Product(
              name: nameController.text,
              purpose: purposeController.text,
            );

            Navigator.of(context).pop(newProduct); // Close the dialog
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
