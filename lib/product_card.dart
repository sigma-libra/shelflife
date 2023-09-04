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
                leading: const Icon(Icons.scale, color: ORANGE,),
                title: Text(product.name, style: defaultTextStyle(),),
                subtitle: Text(product.purpose, style: defaultTextStyle(),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Replace: ${product.replace ? "Yes" : "No"}', style: defaultTextStyle(),),
                    if (product.monthsToReplacement != null)
                      Text('Months to Replacement: ${product.monthsToReplacement}',style: defaultTextStyle(),),
                    if(product.price != null)
                      Text('Cost: ${product.price}', style: defaultTextStyle(),),
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
