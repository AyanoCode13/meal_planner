import 'package:meal_planner/data/local/dao/recipe.dao.dart';
import 'package:meal_planner/data/local/models/recipe.model.dart';
import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:meal_planner/domain/entities/recipe/recipe.entity.dart';
import 'package:meal_planner/service/file.storage.service.dart';
import 'package:meal_planner/utils/result.dart';

final class LocalRecipeRepsitory implements Repository<RecipeEntity>{
  final RecipeDAO _recipeDAO;
  final FileStorageService _fileStorageService;

  LocalRecipeRepsitory({required RecipeDAO recipeDAO, required FileStorageService fileStorageService})
    : _recipeDAO = recipeDAO,
      _fileStorageService = fileStorageService;
  
  @override
  Future<Result<void>> add(RecipeEntity input) async {
    // TODO: implement add
    try{
      // late String image;
      // if(input.image != null){
      //   image = await _fileStorageService.saveFile(
      //     input.image!,
      //     input.id,
      //   );
      // }

      // final recipe = RecipeModel(
      //   id: input.id,
      //   name: input.name,
      //   description: input.description,
      //   price: input.price,
      //   image: image,
      //   preparationTime: input.preparationTime,
      // );
      // final res = await _recipeDAO.insertRecipe(recipe);
      print(input);
      return Result.ok(null);
      
    }on Exception catch(e){
      return Result.error(e);
    }
  }
  
  @override
  Future<Result<void>> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
  
  @override
  Future<Result<List<RecipeEntity>>> getAll() async {
    // TODO: implement getAll
    try{
      final res = await _recipeDAO.getAll();
      final recipes = res.map((e) async => RecipeEntity(
        id: e.id,
        name: e.name,
        description: e.description,
        price: e.price,
        preparationTime: e.preparationTime,
        image: await _fileStorageService.getFile(e.image, e.id),
      )).toList();
      return Result.ok( await Future.wait(recipes));
    } on Exception catch(e){
      return Result.error(e);
    }
  }
  
  @override
  Future<Result<RecipeEntity>> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }
  
  @override
  Future<Result<void>> update(RecipeEntity input) {
    // TODO: implement update
    throw UnimplementedError();
  }


}