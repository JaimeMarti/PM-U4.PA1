import 'package:u4_pa2/domain/entities/wand.dart';

class Character {
  final String name;
  final String house;
  final String? image;
  final Wand wand;

  Character({
    required this.name,
    required this.house,
    required this.image,
    required this.wand
  });
}