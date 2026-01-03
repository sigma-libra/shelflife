import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:shelflife/colors.dart';
import 'package:shelflife/l10n/app_localizations.dart';
import 'package:shelflife/product/product.dart';
import 'package:shelflife/tag/tag.dart';
import 'package:shelflife/tag/tags_page.dart';
import 'package:shelflife/utils.dart';

class AddProductDialog extends StatefulWidget {
  final Product? product;
  final Box<Tag> tagBox;
  final String currencySymbol;

  const AddProductDialog({Key? key, this.product, required this.tagBox, required this.currencySymbol}) : super(key: key);

  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  late TextEditingController nameController;
  late TextEditingController purposeController;
  late TextEditingController monthsToReplacementController;
  late ValueNotifier<bool> replaceValue;
  late TextEditingController priceController;
  late List<Tag> tags;
  late List<Tag> selectedTags;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product?.name ?? "");
    purposeController = TextEditingController(text: widget.product?.purpose ?? "");
    monthsToReplacementController = TextEditingController(text: widget.product?.monthsToReplacement?.toString() ?? "");
    replaceValue = ValueNotifier<bool>(widget.product?.replace ?? false);
    final initialPrice = widget.product?.price == null ? "" : widget.product?.price.toString();
    priceController = TextEditingController(text: initialPrice);
    tags = widget.tagBox.values.toList();
    final existingTagNames = {for (var v in tags) v.name: v};
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
      title: Text(AppLocalizations.of(context)!.addNewProduct),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            textField(nameController, AppLocalizations.of(context)!.productName),
            textField(purposeController, AppLocalizations.of(context)!.productPurpose),
            numberField(priceController, AppLocalizations.of(context)!.price, decimals: 2, isCurrency: true),
            numberField(monthsToReplacementController, AppLocalizations.of(context)!.monthsToReplacement, decimals: 0),
            boolField(AppLocalizations.of(context)!.getAgain, replaceValue),
            tagField(widget.product)
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TagsPage(
                    tagsBox: widget.tagBox,
                  ),
                ),
              ).then((value) => setState(() {
                    tags = widget.tagBox.values.toList();
                  }));
            },
            child: Text(AppLocalizations.of(context)!.editTags)),
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
          child: Text((widget.product != null) ? AppLocalizations.of(context)!.save : AppLocalizations.of(context)!.add),
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
            isDismissible: false,
            backgroundColor: JAR_GREEN,
            buttonText: Text(AppLocalizations.of(context)!.selectTags),
            title: Text(tags.isEmpty ? AppLocalizations.of(context)!.noTagsToSelect : AppLocalizations.of(context)!.selectTags),
            initialValue: selectedTags,
            items: tags.map((e) => MultiSelectItem(e, e.name)).toList(),
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
