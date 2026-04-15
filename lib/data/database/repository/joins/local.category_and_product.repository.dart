import 'package:meal_planner/domain/domain.dart';
import 'package:meal_planner/domain/entities/category/category.entity.dart';

import '../../../../utils/result.dart';
import '../../dao/joins/categories_and_products.dao.dart';

class CategoriesAndProductsRepository {
  final CategoriesAndProductsDAO _categoriesAndProductsDAO;

  CategoriesAndProductsRepository({required CategoriesAndProductsDAO categoriesAndProductsDAO}) : _categoriesAndProductsDAO = categoriesAndProductsDAO;

  Future<Result<List<ProductEntity>>> getCategoryProducts(CategoryEntity data) async {
    try{
      final res = await _categoriesAndProductsDAO.getCategoryProducts(data.id);
      final products = res.map((e) => ProductEntity.fromModel(data: e)).toList();
      return Result.ok(products);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}