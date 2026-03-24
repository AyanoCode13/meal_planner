// recipe_product_join_dao.dart
import 'package:floor/floor.dart';
import 'package:meal_planner/data/local/models/recipes_and_products.dart';

@dao
abstract class RecipesAndProductsDAO {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(RecipeProductModel data);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<RecipeProductModel> data);
}