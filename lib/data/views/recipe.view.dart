import 'package:floor/floor.dart';
import '../sql/sql.dart';

@DatabaseView(
  getAllRecipes,
  viewName: 'recipe_view'
)
class Recipe{
  final String id;
  final String name;
  final String description;
  final double? total; 
  final String? file;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.total, 
    required this.file, 
  });
}


