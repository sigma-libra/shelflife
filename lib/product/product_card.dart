import 'package:flutter/material.dart';
import 'package:shelflife/colors.dart';
import 'package:shelflife/product/product.dart';
import 'package:shelflife/tag/tag.dart';
import 'package:shelflife/utils.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onDuplicate;
  final List<Tag> tags;
  final String currencySymbol;

  const ProductCard(
      {super.key,
      required this.product,
      required this.onDelete,
      required this.onEdit,
      required this.onDuplicate,
      required this.tags,
      required this.currencySymbol});

  @override
  Widget build(BuildContext context) {
    final tagMap = {for (var v in tags) v.name: v};
    return Dismissible(
      key: Key(product.productId.toString()),
      onDismissed: (dismissed) => onDelete(),
      child: Card(
        color: SHELF_BROWN,
        elevation: 4,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  tileColor: SHELF_TOP_BROWN,
                  leading: const Icon(
                    Icons.scale,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Text(
                      product.name,
                      style: defaultTextStyle(),
                    ),
                  ),
                  subtitle: Text(
                    product.purpose,
                    style: defaultTextStyle(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Get Again: ${product.replace ? "Yes" : "No"}',
                          style: defaultTextStyle(),
                        ),
                      ),
                      if (product.monthsToReplacement != null)
                        Text(
                          'Months to Replacement: ${Utils.monthsLeftOnProduct(product)}',
                          style: defaultTextStyle(),
                        ),
                      if (product.price != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Cost: $currencySymbol${product.price}',
                            style: defaultTextStyle(),
                          ),
                        ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (String tag in product.tags.where((tag) => tagMap.keys.contains(tag)))
                              Chip(
                                label: Text(tag),
                                backgroundColor: Color(tagMap[tag]!.color),
                                labelStyle: defaultTextStyle(),
                                side: const BorderSide(color: SHELF_BROWN),
                                visualDensity: VisualDensity.compact,
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: onDelete,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: defaultBoxDecoration(),
                  child: const Icon(
                    Icons.close,
                    size: 16,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 40,
              child: GestureDetector(
                onTap: onEdit,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: defaultBoxDecoration(),
                  child: const Icon(
                    Icons.edit,
                    size: 16,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 72,
              child: GestureDetector(
                onTap: onDuplicate,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: defaultBoxDecoration(),
                  child: const Icon(
                    Icons.copy,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle defaultTextStyle() {
    return const TextStyle(color: BLACK_BROWN);
  }

  BoxDecoration defaultBoxDecoration() {
    return const BoxDecoration(
      shape: BoxShape.rectangle,
      color: JAR_GREEN,
    );
  }
}
