import 'package:flutter/material.dart';
import 'package:shelflife/colors.dart';
import 'package:shelflife/product/product.dart';

class AddProductDialog extends StatefulWidget {
  final Product? product;

  const AddProductDialog({Key? key, this.product}) : super(key: key);

  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  late TextEditingController nameController;
  late TextEditingController purposeController;
  late TextEditingController monthsToReplacementController;
  late ValueNotifier<bool> replaceValue;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product?.name ?? "");
    purposeController = TextEditingController(text: widget.product?.purpose ?? "");
    monthsToReplacementController = TextEditingController(text: widget.product?.monthsToReplacement?.toString() ?? "");
    replaceValue = ValueNotifier<bool>(widget.product?.replace ?? false);
    priceController = TextEditingController(text: widget.product?.price.toString() ?? "");
  }

  @override
  void dispose() {
    replaceValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: widget.product?.name ?? "");
    TextEditingController purposeController = TextEditingController(text: widget.product?.purpose ?? "");
    TextEditingController monthsToReplacementController = TextEditingController(text: widget.product?.monthsToReplacement?.toString() ?? "");
    ValueNotifier<bool> replaceValue = ValueNotifier<bool>(widget.product?.replace ?? false);
    TextEditingController priceController = TextEditingController(text: widget.product?.price.toString() ?? "");

    return AlertDialog(
      backgroundColor: PALE_ORANGE,
      title: const Text('Add New Product'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          textField(nameController, "Product Name"),
          textField(purposeController, "Product Purpose"),
          numberField(priceController, "Price", decimals: 2),
          numberField(monthsToReplacementController, "Months to Replacement", decimals: 0),
          boolField("Replace", replaceValue),
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
            Product product = Product(
              name: nameController.text,
              purpose: purposeController.text,
              monthsToReplacement: int.tryParse(monthsToReplacementController.text),
              replace: replaceValue.value,
              price: double.tryParse(priceController.text),
            );

            Navigator.of(context).pop(product); // Close the dialog
          },
          child: Text((widget.product != null) ? "Edit" : 'Add'),
        ),
      ],
    );
  }

  TextField textField(TextEditingController controller, String fieldLabel) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: fieldLabel),
    );
  }

  Row boolField(String label, ValueNotifier<bool> fieldValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 4.0),
          child: ValueListenableBuilder<bool>(
            valueListenable: fieldValue,
            builder: (context, value, child) {
              return Switch(
                activeColor: WALL_BLUE,
                value: value,
                onChanged: (newValue) {
                  fieldValue.value = newValue;
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Row numberField(TextEditingController controller, String fieldLabel, {int decimals = 0}) {
    TextInputType keyboardType = (decimals > 0) ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.number;
    double textFieldWidth = (decimals > 0) ? (decimals * 16.0) + 40.0 : 50.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(fieldLabel),
        SizedBox(
          width: textFieldWidth,
          child: Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
