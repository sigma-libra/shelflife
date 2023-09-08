import 'package:flutter/material.dart';
import 'package:shelflife/colors.dart';
import 'package:shelflife/product/product.dart';
import 'package:shelflife/tag/tag.dart';
import 'package:shelflife/utils.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final List<Tag> tags;

  const ProductCard({super.key, required this.product, required this.onDelete, required this.onEdit, required this.tags});

  @override
  Widget build(BuildContext context) {
    final tagMap = {for (var v in tags) v.name: v};
    return Card(
      color: LIGHT_BROWN,
      elevation: 4,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.scale,
                  color: ORANGE,
                ),
                title: Text(
                  product.name,
                  style: defaultTextStyle(),
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
                    Text(
                      'Replace: ${product.replace ? "Yes" : "No"}',
                      style: defaultTextStyle(),
                    ),
                    if (product.monthsToReplacement != null)
                      Text(
                        'Months to Replacement: ${Utils.monthsLeftOnProduct(product)}',
                        style: defaultTextStyle(),
                      ),
                    if (product.price != null)
                      Text(
                        'Cost: ${product.price}',
                        style: defaultTextStyle(),
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
                              side: const BorderSide(color: LIGHT_BROWN),
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
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: defaultBoxDecoration(),
                child: const Icon(
                  Icons.close,
                  color: ORANGE,
                  size: 16,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: GestureDetector(
              onTap: onEdit,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: defaultBoxDecoration(),
                child: const Icon(
                  Icons.edit,
                  color: ORANGE,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle defaultTextStyle() {
    return const TextStyle(color: BLACK_BROWN);
  }

  BoxDecoration defaultBoxDecoration() {
    return const BoxDecoration(
      shape: BoxShape.rectangle,
      color: DARK_BROWN,
    );
  }
}
