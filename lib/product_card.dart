import 'package:flutter/material.dart';
import 'package:porcelain/product/product.dart';


class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ProductCard({super.key, required this.product, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Stack(
        children: [
          Column(
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
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.purple,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
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
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.purple,
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
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
