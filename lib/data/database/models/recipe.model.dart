import 'package:floor/floor.dart';
import 'package:meal_planner/domain/domain.dart';

@Entity(
  tableName: 'recipes',
  primaryKeys: ['id'],
  indices: [
    Index(value: ['id'], unique: true),
    Index(value: ['name'], unique: true),
  ],
)
class RecipeModel {
  final String id;
  final String name;
  final String? description;
  final Duration preparationTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  RecipeModel({
    required this.name,
    required this.description,
    required this.preparationTime,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

   factory RecipeModel.fromEntity({ required RecipeEntity data}){
    return RecipeModel(id: data.id, name: data.name, description: data.description, preparationTime: Duration.zero, createdAt: DateTime.now(), updatedAt: DateTime.now(), );
  }
}
