import 'package:floor/floor.dart';
import 'package:meal_planner/data/database/models/recipe.model.dart';
import 'package:meal_planner/data/database/views/views.dart';
import 'package:meal_planner/domain/abstract/dao.dart';

@dao
abstract class RecipeDAO implements DAO<RecipeModel, RecipeView> {
  @Query('SELECT * FROM recipe_view')
  @override
  Future<List<RecipeView>> findAll();

  @Query('SELECT * FROM recipe_view WHERE id = :id')
  @override
  Future<RecipeView?> findById(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  @override
  Future<void> insert(RecipeModel data);

  @Insert(onConflict: OnConflictStrategy.replace)
  @override
  Future<void> insertAll(List<RecipeModel> data);

  @Update(onConflict: OnConflictStrategy.replace)
  @override
  Future<void> update(RecipeModel data);

  @Update(onConflict: OnConflictStrategy.replace)
  @override
  Future<void> updateAll(List<RecipeModel> data);

  @delete
  @override
  Future<void> removeAll(List<RecipeModel> data);

  @delete
  @override
  Future<void> remove(RecipeModel id);
}
