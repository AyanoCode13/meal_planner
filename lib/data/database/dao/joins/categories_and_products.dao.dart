import 'package:floor/floor.dart';
import 'package:meal_planner/data/database/models/joins/categories_and_products.dart';

import '../../models/product.model.dart';

@dao
abstract class CategoriesAndProductsDAO {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(CategoryProductModel data);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAll(List<CategoryProductModel> data);

  @Query('''
    SELECT p.* FROM products p
    INNER JOIN category_product_join rpj ON p.id = rpj.productId
    WHERE rpj.categoryId = :categoryId
  ''')
  Future<List<ProductModel>> getCategoryProducts(String categoryId);
}