import 'package:meal_planner/domain/abstract/use_case.dart';
import 'package:meal_planner/domain/entities/recipe/recipe.entity.dart';
class GetAllRecipesUseCase extends GetAllUseCase<RecipeEntity>{
  GetAllRecipesUseCase({required super.repository}); 
}

final class GetRecipeByIdUseCase extends GetByIdUseCase<RecipeEntity>{
  GetRecipeByIdUseCase({required super.repository});
}

class AddRecipeUseCase extends AddUseCase<RecipeEntity> {
  AddRecipeUseCase({required super.repository});
}

class UpdateRecipeUseCase extends UpdateUseCase<RecipeEntity> {
  UpdateRecipeUseCase({required super.repository});
}


class DeleteRecipeUseCase extends DeleteUseCase<RecipeEntity> {
  DeleteRecipeUseCase({required super.repository});
}

