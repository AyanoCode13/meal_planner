import 'package:meal_planner/data/local/repository/local/local.product.repository.dart';
import 'package:meal_planner/data/local/repository/local/local.recipe.repository.dart';
import 'package:meal_planner/domain/abstract/use_case.dart';
import 'package:meal_planner/domain/entities/recipe/recipe.entity.dart';
import 'package:meal_planner/utils/result.dart';

final class GetRecipeByIdUseCase extends UseCase<String, RecipeEntity?> {
  final LocalRecipeRepository _recipeRepsitory;
  final LocalProductRepository _productRepository;

  GetRecipeByIdUseCase({
    required LocalRecipeRepository recipeRepsitory,
    required LocalProductRepository productRepository,
  }) : _recipeRepsitory = recipeRepsitory,
       _productRepository = productRepository;

  @override
  Future<Result<RecipeEntity?>> call({required String input}) async {
    // TODO: implement call
    try {
      final (recipe, ingredients) = await (
        _recipeRepsitory.getById(input),
        _productRepository.getRecipeProducts(id: input),
      ).wait;
      if (recipe != null) {
        return Result.ok(recipe.copyWith(ingredients: ingredients));
      }
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
