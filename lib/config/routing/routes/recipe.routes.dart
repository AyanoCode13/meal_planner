import 'package:meal_planner/domain/entities/recipe/recipe.entity.dart';

abstract final class RecipeRoutes {
  static String view(RecipeEntity recipe) => "/recipes/${recipe.id}";
  static const String add = '/recipes/add';
}
