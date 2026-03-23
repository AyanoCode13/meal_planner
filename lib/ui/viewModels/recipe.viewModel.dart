import 'package:flutter/foundation.dart';
import 'package:logger/web.dart';
import 'package:meal_planner/domain/dto/recipe/create.recipe.dto.dart';
import 'package:meal_planner/domain/entities/recipe/recipe.entity.dart';
import 'package:meal_planner/domain/useCase/product/getById.useCase.dart';
import 'package:meal_planner/domain/useCase/recipe/add.useCase.dart';
import 'package:meal_planner/domain/useCase/recipe/getAll.useCase.dart';
import 'package:meal_planner/domain/useCase/recipe/getById.useCase.dart';
import 'package:meal_planner/utils/command.dart';
import 'package:meal_planner/utils/result.dart';

final class RecipeViewModel extends ChangeNotifier {
  final AddRecipeUseCase _addRecipeUseCase;
  final GetAllRecipesUseCase _getAllRecipesUseCase;
  final GetRecipeByIdUseCase _getRecipeByIdUseCase;
  RecipeViewModel({
    required AddRecipeUseCase addRecipeUseCase,
    required GetAllRecipesUseCase getAllRecipesUseCase,
    required GetRecipeByIdUseCase getRecipeByIdUseCase,
  }) : _addRecipeUseCase = addRecipeUseCase,
       _getAllRecipesUseCase = getAllRecipesUseCase,
       _getRecipeByIdUseCase = getRecipeByIdUseCase {
    load = BasicCommand(_load)..execute();
    add = ComplexCommand(_add);
    getById = ComplexCommand(_getById);
  }
  late List<RecipeEntity> _recipes;
  List<RecipeEntity> get recipes => _recipes;

  late RecipeEntity? _recipe;
  RecipeEntity? get recipe => _recipe;

  late final ComplexCommand<void, CreateRecipeDTO> add;
  late final ComplexCommand<void, String> getById;
  late BasicCommand load;

  final Logger _logger = Logger();

  List<Command> get commands => [load, add];

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

  Future<Result<void>> _getById(String id) async {
    try {
      final res = await _getRecipeByIdUseCase.call(input: id);
      switch (res) {
        case Ok<RecipeEntity?>():
          _recipe = res.value;
          
        case Error<RecipeEntity?>():
          _logger.e(res.error);
      }
      return res;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _add(CreateRecipeDTO data) async {
    try {
      _logger.i(data);
      final res = await _addRecipeUseCase.call(input: data);
      switch (res) {
        case Ok<RecipeEntity>():
          await _load();
          return Result.ok(null);
        case Error<RecipeEntity>():
          return Result.error(res.error);
      }
    } finally {
      notifyListeners();
    }
  }
}
