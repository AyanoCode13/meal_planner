

import 'dart:io';

import 'package:meal_planner/data/local/dao/product.dao.dart';
import 'package:meal_planner/data/local/models/product.model.dart';
import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';

class LocalProductRepository
    extends LocalRepository<ProductEntity, ProductModel, ProductModel> {
  final ProductDAO _productDAO;

  LocalProductRepository({
    required ProductDAO productDAO,
    required super.imageDAO,
    required super.fileStorageService,
  })  : _productDAO = productDAO;

  @override
  Future<List<ProductModel>> fetchAll() => _productDAO.findAll();

  @override
  Future<ProductModel?> fetchById(String id) => _productDAO.findById(id);

  @override
  Future<void> insertModel(ProductModel model) => _productDAO.insert(model);

  @override
  Future<void> updateModel(ProductModel model) => _productDAO.update(model);

  @override
  Future<void> removeModel(ProductModel model) => _productDAO.remove(model);

  @override
  String idOf(ProductModel model) => model.id;

  @override
  String entityIdOf(ProductEntity entity) => entity.id;

  @override
  List<File?> imagesOf(ProductEntity entity) => entity.images;

  @override
  ProductModel toWriteModel(ProductEntity entity) =>
      ProductModel.fromEntity(data: entity);

  @override
  ProductEntity toEntity(ProductModel model, List<File?> images) =>
      ProductEntity.fromModel(data: model, images: images);
}