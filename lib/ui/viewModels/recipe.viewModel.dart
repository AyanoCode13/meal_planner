import 'package:flutter/foundation.dart';
import 'package:logger/web.dart';
import 'package:meal_planner/domain/dto/recipe/create.recipe.dto.dart';
import 'package:meal_planner/domain/entities/recipe/recipe.entity.dart';
import 'package:meal_planner/domain/useCase/recipe/add.useCase.dart';
import 'package:meal_planner/domain/useCase/recipe/getAll.useCase.dart';
import 'package:meal_planner/utils/command.dart';
import 'package:meal_planner/utils/result.dart';

final class RecipeViewModel extends ChangeNotifier {
  final AddRecipeUseCase _addRecipeUseCase;
  final GetAllRecipesUseCase _getAllRecipesUseCase;

  RecipeViewModel({
    required AddRecipeUseCase addRecipeUseCase,
    required GetAllRecipesUseCase getAllRecipesUseCase,
  }) : _addRecipeUseCase = addRecipeUseCase,
       _getAllRecipesUseCase = getAllRecipesUseCase {
    load = BasicCommand(_load)..execute();
    add = ComplexCommand(_add);
  }
  late List<RecipeEntity> _recipes;
  List<RecipeEntity> get recipes => _recipes;

  late final ComplexCommand<void, CreateRecipeDTO> add;
  late BasicCommand load;

  final Logger _logger = Logger();

  Future<Result<void>> _load() async {
    try {
      final res = await _getAllRecipesUseCase.call(input: null);
      switch (res) {
        case Ok<List<RecipeEntity>>():
          _recipes = res.value;
        case Error<List<RecipeEntity>>():
          Result.error(res.error);
      }
      return res;
    } finally {
      notifyListeners();
    }
  }

   Future<Result<void>> _add(CreateRecipeDTO data) async {
    try {
      final res = await _addRecipeUseCase.call(input: data);
      switch (res) {
        case Ok<RecipeEntity>():
         
          
          return Result.ok(null);
        case Error<RecipeEntity>():
          return Result.error(res.error);
      }
    } finally {
      notifyListeners();
    }
  }
}
