import 'package:floor/floor.dart';


@Entity(
  tableName: 'recipes',
  primaryKeys: ['id'],
  indices: [
    Index(value: ['id'], unique: true),
    Index(value: ['name'], unique: true),
  ],
)
final class RecipeModel {
  final String id;
  final String name;
  final String? description;
  final String? image;
  final String preparationTime;

  RecipeModel({required this.id, required this.name, required this.description,  required this.image, required this.preparationTime});

}
