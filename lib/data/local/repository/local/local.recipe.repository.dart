import 'package:meal_planner/data/local/dao/product.dao.dart';
import 'package:meal_planner/data/local/dao/recipe.dao.dart';
import 'package:meal_planner/data/local/dao/recipes_and_products.dao.dart';
import 'package:meal_planner/data/local/models/recipe.model.dart';
import 'package:meal_planner/data/local/models/recipes_and_products.dart';
import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:meal_planner/domain/entities/recipe/recipe.entity.dart';
import 'package:meal_planner/service/file.storage.service.dart';
import 'package:meal_planner/utils/result.dart';

final class LocalRecipeRepository implements Repository<RecipeEntity> {
  final RecipeDAO _recipeDAO;
  final ProductDAO _productDAO;
  final FileStorageService _fileStorageService;
  final RecipesAndProductsDAO _recipesAndProductsDAO;

  LocalRecipeRepository({
    required RecipeDAO recipeDAO,
    required ProductDAO productDAO,
    required FileStorageService fileStorageService,
    required RecipesAndProductsDAO recipesAndProductsDAO,
  }) : _recipeDAO = recipeDAO,
       _productDAO = productDAO,
       _fileStorageService = fileStorageService,
       _recipesAndProductsDAO = recipesAndProductsDAO;

  @override
  Future<void> add(RecipeEntity input) async {
    // TODO: implement add
    try {
      print(input.image);
      final recipe = await _toModel(entity: input);
      await _recipeDAO.insertRecipe(recipe);
      List<RecipeProductModel> joins = input.ingredients
          .map(
            (i) => RecipeProductModel(
              recipeId: input.id,
              productId: i.id,
              quantity: i.quantity,
            ),
          )
          .toList();

      await _recipesAndProductsDAO.insertMany(joins);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    // TODO: implement delete
    try {
      await (_recipeDAO.delete(id), _fileStorageService.deleteFiles(folder: id)).wait;
    } catch (e){
      rethrow;
    }
  }

  @override
  Future<List<RecipeEntity>> getAll() async {
    // TODO: implement getAll
    // try {
    //   final res = await _recipeDAO.getAll();
    //   final recipes = res.map((e) async => await _toEntity(model: e.)).toList();

    //   return await recipes.wait;
    // } catch (e) {
    //   rethrow;
    // }
    throw UnimplementedError();
  }

  @override
  Future<RecipeEntity?> getById(String id) async {
    // TODO: implement getById

    final recipe = await _recipeDAO.findById(id);

    try {
      if (recipe == null) {
        return null;
      }
      return await _toEntity(model: recipe);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Result<void>> update(RecipeEntity input) {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<RecipeEntity> _toEntity({required RecipeModel model}) async {
    final (total, image) = await (_recipeDAO.calculateTotal(model.id), _fileStorageService.getFile(
              folder: model.id,
              fileName: model.image!,
            )).wait;
    return RecipeEntity(
      id: model.id,
      name: model.name,
      description: model.description,
      price: total ?? 0.0,
      preparationTime: model.preparationTime,
      ingredients: [],
      image: image
    );
  }

  Future<RecipeModel> _toModel({required RecipeEntity entity}) async {
    return RecipeModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      
      image: entity.image != null
          ? await _fileStorageService.saveFile(
              file: entity.image!,
              folder: entity.id,
            )
          : null,
      preparationTime: entity.preparationTime,
    );
  }
}
