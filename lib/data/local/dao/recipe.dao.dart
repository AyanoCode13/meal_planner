import 'package:floor/floor.dart';
import 'package:meal_planner/data/local/models/recipe.model.dart';
import 'package:meal_planner/data/views/views.dart';

@dao
abstract class RecipeDAO {
 
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRecipe(RecipeModel recipe);

  
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMany(List<RecipeModel> recipe);

  @Query('SELECT * FROM recipe_view')
  Future<List<Recipe>> getAll();


  @Query('SELECT * FROM recipes WHERE id = :id')
  Future<RecipeModel?> findById(String id);

 
  @Query('DELETE FROM recipes WHERE id = :id')
  Future<void> delete(String id);

  @Query('''
    SELECT COALESCE(SUM(p.price * j.quantity), 0.0)
    FROM products p
    INNER JOIN recipe_product_join j ON j.product_id = p.id
    WHERE j.recipe_id = :recipeId
  ''')
  Future<double?> _calculateTotal(String recipeId);

  Future<double> calculateTotal(String recipeId) async {
    return await _calculateTotal(recipeId) ?? 0.0;
  }
}
