import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:meal_planner/domain/abstract/use_case.dart';
import 'package:meal_planner/domain/dto/recipe/create.recipe.dto.dart';
import 'package:meal_planner/domain/entities/recipe/recipe.entity.dart';

import 'package:meal_planner/utils/result.dart';

final class AddRecipeUseCase extends UseCase<CreateRecipeDTO, void> {
  final Repository<RecipeEntity> _repository;

  AddRecipeUseCase({required Repository<RecipeEntity> repository})
    : _repository = repository;

  @override
  Future<Result<RecipeEntity>> call({required CreateRecipeDTO input}) async {
    // TODO: implement call
    final recipe = RecipeEntity.create(dto: input);
    try {
      await _repository.add(recipe);
      return Result.ok(recipe);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
