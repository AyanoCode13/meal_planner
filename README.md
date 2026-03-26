# meal_planner

A new Flutter project.

# Floor Database
    flutter packages pub run build_runner watch
# Mockito
    dart run build_runner build watch --delete-conflicting-outputs
# Repository Tests
    flutter test test/db/repositories --reporter expanded
# Product Repository
    flutter test test/db/repositories/product/product.repository_test.dart --reporter expanded
# Recipe Repository 
    flutter test test/db/repositories/product/recipe.repository_test.dart --reporter expanded
Future<RecipeEntity> withDetails(RecipeEntity model) async {
    final res = await _productDAO.getProductsForRecipe(model.id);
    final ingredients = res.map((e) => ProductEntity.asIngredient(data: e)).toList();
    return model.copyWith(ingredients: ingredients);
  }

    Future<Result<List<ProductEntity>>> getProductsForRecipe(
    String recipeId,
  ) async {
    try {
      final products = await _productDAO.getProductsForRecipe(recipeId);
      return Result.ok(
        products.map((e) => ProductEntity.asIngredient(data: e)).toList(),
      );
    } on Exception catch (e) {
      return Result.error(e);
    }
  }