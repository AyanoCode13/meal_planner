import 'package:meal_planner/data/database/models/category.model.dart';

import '../../../domain/abstract/repository.dart';
import '../../../domain/domain.dart';

class LocalProductRepository
    extends LocalRepository<ProductEntity, CategoryModel, CategoryModel> {
      
  @override
  String entityIdOf(ProductEntity entity) {
    // TODO: implement entityIdOf
    throw UnimplementedError();
  }

  @override
  Future<List<CategoryModel>> fetchAll() {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }

  @override
  Future<CategoryModel?> fetchById(String id) {
    // TODO: implement fetchById
    throw UnimplementedError();
  }

  @override
  String idOf(CategoryModel model) {
    // TODO: implement idOf
    throw UnimplementedError();
  }

  @override
  Future<void> insertModel(CategoryModel model) {
    // TODO: implement insertModel
    throw UnimplementedError();
  }

  @override
  Future<void> removeModel(CategoryModel model) {
    // TODO: implement removeModel
    throw UnimplementedError();
  }

  @override
  ProductEntity toEntity(CategoryModel model) {
    // TODO: implement toEntity
    throw UnimplementedError();
  }

  @override
  CategoryModel toWriteModel(ProductEntity entity) {
    // TODO: implement toWriteModel
    throw UnimplementedError();
  }

  @override
  Future<void> updateModel(CategoryModel model) {
    // TODO: implement updateModel
    throw UnimplementedError();
  }
}
