import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  Product(
      {required this.name, this.monthsToReplacement, required this.purpose, this.replace = false, this.price = 0});

  @HiveField(0)
  String name;

  @HiveField(1)
  int? monthsToReplacement;

  @HiveField(2)
  String purpose;

  @HiveField(3)
  bool replace;

  @HiveField(4)
  double price;
}
