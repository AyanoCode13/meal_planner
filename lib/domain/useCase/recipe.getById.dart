import 'package:meal_planner/data/local/repository/local/local.repository.dart';
import 'package:meal_planner/domain/abstract/use_case.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';
import 'package:meal_planner/domain/entities/recipe/recipe.entity.dart';
import 'package:meal_planner/utils/result.dart';

class GetRecipeByIdUseCase extends GetByIdUseCase<RecipeEntity> {
  final LocalProductRepository _productRepository;
  final LocalRecipeRepository _recipeRepository;

  GetRecipeByIdUseCase({
    required LocalProductRepository productRepository,
    required LocalRecipeRepository recipeRepository,
  }) : _productRepository = productRepository,
       _recipeRepository = recipeRepository,
       super(repository: recipeRepository);

  @override
  Future<Result<RecipeEntity?>> call({required String data}) async {
    // TODO: implement call
    final recipeResult = await _recipeRepository.getById(data);
    if (recipeResult is Error) return recipeResult;

    final recipe = (recipeResult as Ok<RecipeEntity?>).value;
    if (recipe == null) return Result.ok(recipe);

    final ingredientsResult = await _productRepository.getProductsForRecipe(
      data,
    );
    if (ingredientsResult is Error<List<ProductEntity>>)
      return Result.error(ingredientsResult.error);

    return Result.ok(
      recipe.copyWith(ingredients: (ingredientsResult as Ok).value),
    );
  }
}


