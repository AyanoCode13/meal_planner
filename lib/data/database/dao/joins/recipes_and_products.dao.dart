// recipe_product_join_dao.dart
import 'package:floor/floor.dart';
import 'package:meal_planner/data/database/models/joins/recipes_and_products.dart';

import '../../models/models.dart';

@dao
abstract class RecipesAndProductsDAO {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(RecipeProductModel data);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<RecipeProductModel> data);

  @Query('''
    SELECT p.* FROM products p
    INNER JOIN recipe_product_join rpj ON p.id = rpj.productId
    WHERE rpj.recipeId = :recipeId
  ''')
  Future<List<ProductModel>> getProductsForRecipe(String recipeId);
}