import 'package:meal_planner/data/database/dao/product.dao.dart';
import 'package:meal_planner/data/database/models/product.model.dart';
import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';
import 'package:meal_planner/utils/result.dart';

class LocalProductRepository
    extends LocalRepository<ProductEntity, ProductModel, ProductModel> {
  final ProductDAO _productDAO;

  LocalProductRepository({required ProductDAO productDAO})
    : _productDAO = productDAO;

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
  ProductModel toWriteModel(ProductEntity entity) =>
      ProductModel.fromEntity(data: entity);

  @override
  ProductEntity toEntity(ProductModel model) =>
      ProductEntity.fromModel(data: model);

  Future<Result<List<ProductEntity>>> getProductsForRecipe(String id) async {
    try {
      final res = await _productDAO.getProductsForRecipe(id);
      return Result.ok(
        res.map((e) => ProductEntity.fromModel(data: e)).toList(),
      );
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
