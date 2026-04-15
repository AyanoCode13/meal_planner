import 'package:meal_planner/domain/entities/recipe/recipe.entity.dart';

abstract final class RecipeRoutes {
  static const String all = '/recipes';
  static const String add = '/recipes/add';
  static String view(RecipeEntity recipe) => "/recipes/${recipe.id}";
  
}
