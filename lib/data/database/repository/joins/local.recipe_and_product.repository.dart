import 'package:meal_planner/data/database/dao/dao.dart';
import 'package:meal_planner/domain/domain.dart';

import '../../../../utils/result.dart';

class RecipesAndProductsRepository {
  final RecipesAndProductsDAO _recipesAndProductsDAO;

  RecipesAndProductsRepository({required RecipesAndProductsDAO recipesAndProductsDAO}) : _recipesAndProductsDAO = recipesAndProductsDAO;

  Future<Result<List<ProductEntity>>> getRecipeProducts(RecipeEntity data) async {
    try{
      final res = await _recipesAndProductsDAO.getProductsForRecipe(data.id);
      final products = res.map((e) => ProductEntity.fromModel(data: e)).toList();
      return Result.ok(products);
    }on Exception catch(e) {
      return Result.error(e);
    }
  }
}