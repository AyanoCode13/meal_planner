import 'package:floor/floor.dart';
import 'package:meal_planner/data/local/models/product.model.dart';

@dao
abstract class ProductDAO {
  @Query('SELECT * FROM products')
  Future<List<ProductModel>> findAll();

  @Query('SELECT * FROM products WHERE id = :id')
  Future<ProductModel?> findById(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(ProductModel product);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMany(List<ProductModel> products);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> update(ProductModel product);

  @Query('DELETE FROM products WHERE id = :id')
  Future<void> delete(String id);

  @Query('''
    SELECT p.* FROM products p
    INNER JOIN recipe_product_join rpj ON p.id = rpj.productId
    WHERE rpj.recipeId = :recipeId
  ''')
  Future<List<ProductModel>> getProductsForRecipe(String recipeId);
}
