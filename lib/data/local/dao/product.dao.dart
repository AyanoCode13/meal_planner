import 'package:floor/floor.dart';
import 'package:meal_planner/data/local/models/product.model.dart';
import 'package:meal_planner/domain/abstract/dao.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';

@dao
abstract class ProductDAO extends DAO<ProductModel, ProductModel> {
  @Query('SELECT * FROM products')
  @override
  Future<List<ProductModel>> findAll();

  @Query('SELECT * FROM products WHERE id = :id')
  @override
  Future<ProductModel?> findById(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  @override
  Future<void> insert(ProductModel data);

  @Insert(onConflict: OnConflictStrategy.replace)
  @override
  Future<void> insertAll(List<ProductModel> data);

  @Update(onConflict: OnConflictStrategy.replace)
  @override
  Future<void> update(ProductModel data);

  @Update(onConflict: OnConflictStrategy.replace)
  @override
  Future<void> updateAll(List<ProductModel> data);

  @delete
  @override
  Future<void> removeAll(List<ProductModel> data);

  @delete
  @override
  Future<void> remove(ProductModel data);

  // Get all products for a specific recipe
  @Query('''
    SELECT p.* FROM products p
    INNER JOIN recipe_product_join rpj ON p.id = rpj.productId
    WHERE rpj.recipeId = :recipeId
  ''')
  Future<List<ProductModel>> getProductsForRecipe(String recipeId);
}
