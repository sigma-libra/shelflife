import 'package:flutter/material.dart';
import 'package:shelflife/colors.dart';
import 'package:shelflife/product/product.dart';


class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ProductCard({super.key, required this.product, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: LIGHT_BROWN,
      elevation: 4,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(Icons.scale, color: DARK_BLUE,),
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
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: DARK_BLUE,
                ),
                child: const Icon(
                  Icons.close,
                  color: POT_BEIGE,
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
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: DARK_BLUE,
                ),
                child: const Icon(
                  Icons.edit,
                  color: POT_BEIGE,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
