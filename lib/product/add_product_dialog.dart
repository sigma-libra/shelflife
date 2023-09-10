import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:shelflife/colors.dart';
import 'package:shelflife/product/product.dart';
import 'package:shelflife/tag/tag.dart';
import 'package:shelflife/utils.dart';

class AddProductDialog extends StatefulWidget {
  final Product? product;
  final List<Tag> tags;
  final String currencySymbol;

  const AddProductDialog({Key? key, this.product, required this.tags, required this.currencySymbol}) : super(key: key);

  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  late TextEditingController nameController;
  late TextEditingController purposeController;
  late TextEditingController monthsToReplacementController;
  late ValueNotifier<bool> replaceValue;
  late TextEditingController priceController;
  late List<Tag> selectedTags;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product?.name ?? "");
    purposeController = TextEditingController(text: widget.product?.purpose ?? "");
    monthsToReplacementController = TextEditingController(text: widget.product?.monthsToReplacement?.toString() ?? "");
    replaceValue = ValueNotifier<bool>(widget.product?.replace ?? false);
    priceController = TextEditingController(text: widget.product?.price.toString() ?? "");
    final existingTagNames = {for (var v in widget.tags) v.name: v};
    selectedTags = widget.product?.tags != null
        ? widget.product!.tags
            .where((productTag) => existingTagNames.keys.contains(productTag))
            .map((productTag) => existingTagNames[productTag]!)
            .toList()
        : List.empty(growable: true);
  }

  @override
  void dispose() {
    replaceValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Product'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            textField(nameController, "Product Name"),
            textField(purposeController, "Product Purpose"),
            numberField(priceController, "Price", decimals: 2, isCurrency: true),
            numberField(monthsToReplacementController, "Months to Replacement", decimals: 0),
            boolField("Replace", replaceValue),
            tagField(widget.product)
          ],
        ),
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
                productId: widget.product?.productId ?? Utils.randomId(),
                name: nameController.text,
                saveTime: DateTime.now().millisecondsSinceEpoch,
                monthsToReplacement: int.tryParse(monthsToReplacementController.text),
                purpose: purposeController.text,
                replace: replaceValue.value,
                price: double.tryParse(priceController.text),
                tags: selectedTags.map((e) => e.name).toList());

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
        ValueListenableBuilder<bool>(
          valueListenable: fieldValue,
          builder: (context, value, child) {
            return Switch(
              activeColor: JAR_RED,
              value: value,
              onChanged: (newValue) {
                fieldValue.value = newValue;
              },
            );
          },
        ),
      ],
    );
  }

  Row numberField(TextEditingController controller, String fieldLabel, {int decimals = 0, bool isCurrency = false}) {
    TextInputType keyboardType = (decimals > 0) ? const TextInputType.numberWithOptions(decimal: true) : TextInputType.number;
    double textFieldWidth = (decimals > 0) ? (decimals * 16.0) + 40.0 : 50.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(fieldLabel),
        SizedBox(
          width: textFieldWidth,
          child: Row(
            children: [
              if (isCurrency)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(widget.currencySymbol),
                ),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row tagField(Product? product) {
    return Row(
      children: [
        Expanded(
          child: MultiSelectDialogField<Tag>(
            buttonText: const Text("Select Tags"),
            title: const Text("Tags"),
            initialValue: selectedTags,
            items: widget.tags.map((e) => MultiSelectItem(e, e.name)).toList(),
            onConfirm: (values) {
              selectedTags = values;
            },
            colorator: (tag) => Color(tag.color),
            itemsTextStyle: const TextStyle(color: BLACK_BROWN),
            selectedItemsTextStyle: const TextStyle(color: BLACK_BROWN),
            listType: MultiSelectListType.CHIP,
            chipDisplay: MultiSelectChipDisplay(
              items: selectedTags.map((e) => MultiSelectItem(e, e.name)).toList(),
              onTap: (value) => setState(() {
                selectedTags.remove(value);
              }),
              colorator: (tag) => Color(tag.color),
              textStyle: const TextStyle(color: BLACK_BROWN),
              scroll: true,
            ),
          ),
        )
      ],
    );
  }
}
