import 'package:hive/hive.dart';

part 'tag.g.dart';

@HiveType(typeId: 1)
class Tag extends HiveObject {
  Tag({required this.name, required this.color});

  @HiveField(0)
  String name;

  @HiveField(1)
  int color;
}
