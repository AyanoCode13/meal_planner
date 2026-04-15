import 'package:floor/floor.dart';
import 'package:meal_planner/data/database/models/category.model.dart';

import '../../../domain/abstract/dao.dart';

@dao
abstract class ProductDAO extends DAO<CategoryModel, CategoryModel> {
  @Query('SELECT * FROM categories')
  @override
  Future<List<CategoryModel>> findAll(); 
}