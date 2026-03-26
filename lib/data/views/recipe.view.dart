import 'package:floor/floor.dart';
import '../sql/sql.dart';

@DatabaseView(
  getAllRecipes,
  viewName: 'recipe_view'
)
class RecipeView{
  final String id;
  final String name;
  final String description;
  final double? total; 
  
  final int preparationTime;
  final DateTime createdAt;
  final DateTime upatedAt;

  RecipeView({required this.id, required this.name, required this.description, required this.total, required this.preparationTime, required this.createdAt, required this.upatedAt});


}


