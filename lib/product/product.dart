import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  Product(
      {required this.productId,
      required this.name,
      required this.saveTime,
      this.monthsToReplacement,
      required this.purpose,
      this.replace = false,
      this.price,
      required this.tags});

  @HiveField(0)
  int productId;

  @HiveField(1)
  String name;

  @HiveField(2)
  int saveTime;

  @HiveField(3)
  int? monthsToReplacement;

  @HiveField(4)
  String purpose;

  @HiveField(5)
  bool replace;

  @HiveField(6)
  double? price;

  @HiveField(7)
  List<String> tags = List.empty();
}
