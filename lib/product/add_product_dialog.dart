import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shelflife/product/product.dart';

class AddProductDialog extends StatelessWidget {

  Product? product;

  AddProductDialog({super.key, this.product});


  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: product?.name ?? "");
    TextEditingController purposeController = TextEditingController(text: product?.purpose ?? "");
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
            product = Product(
              name: nameController.text,
              purpose: purposeController.text,
            );

            Navigator.of(context).pop(product); // Close the dialog
          },
          child: Text((product != null) ? "Edit":'Add'),
        ),
      ],
    );
  }
}
