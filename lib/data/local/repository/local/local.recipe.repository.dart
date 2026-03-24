
import 'dart:io';

import 'package:meal_planner/data/local/dao/recipe.dao.dart';
import 'package:meal_planner/data/local/dao/recipes_and_products.dao.dart';
import 'package:meal_planner/data/local/models/recipe.model.dart';
import 'package:meal_planner/data/local/models/recipes_and_products.dart';
import 'package:meal_planner/data/views/recipe.view.dart';
import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:meal_planner/domain/entities/recipe/recipe.entity.dart';

class LocalRecipeRepository
    extends LocalRepository<RecipeEntity, RecipeView, RecipeModel> {
  final RecipeDAO _recipeDAO;
  final RecipesAndProductsDAO _recipesAndProductsDAO;

  LocalRecipeRepository({
    required RecipeDAO recipeDAO,
    required super.imageDAO,
    required super.fileStorageService,
    required RecipesAndProductsDAO recipesAndProductsDAO,
  })  : _recipeDAO = recipeDAO,
        _recipesAndProductsDAO = recipesAndProductsDAO;

  @override
  Future<List<RecipeView>> fetchAll() => _recipeDAO.findAll();

  @override
  Future<RecipeView?> fetchById(String id) => _recipeDAO.findById(id);

  @override
  Future<void> insertModel(RecipeModel model) => _recipeDAO.insert(model);

  @override
  Future<void> updateModel(RecipeModel model) => _recipeDAO.update(model);

  @override
  Future<void> removeModel(RecipeModel model) => _recipeDAO.remove(model);

  @override
  String idOf(RecipeView model) => model.id;

  @override
  String entityIdOf(RecipeEntity entity) => entity.id;

  @override
  List<File?> imagesOf(RecipeEntity entity) => entity.images;

  @override
  RecipeModel toWriteModel(RecipeEntity entity) =>
      RecipeModel.fromEntity(data: entity);

  @override
  RecipeEntity toEntity(RecipeView model, List<File?> images) =>
      RecipeEntity.fromView(data: model, images: images);

  // Insert join table rows after a recipe is saved
  @override
  Future<void> onAfterInsert(RecipeEntity entity) async {
    final joins = entity.ingredients
        .map(
          (i) => RecipeProductModel(
            recipeId: entity.id,
            productId: i.id,
            quantity: i.quantity,
          ),
        )
        .toList();
    await _recipesAndProductsDAO.insertAll(joins);
  }
}