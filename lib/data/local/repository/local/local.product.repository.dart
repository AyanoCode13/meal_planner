import 'package:meal_planner/data/local/dao/product.dao.dart';
import 'package:meal_planner/data/local/models/product.model.dart';
import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';
import 'package:meal_planner/service/file.storage.service.dart';

final class LocalProductRepository implements Repository<ProductEntity> {
  final ProductDAO _productDAO;
  final FileStorageService _fileStorageService;

  LocalProductRepository({
    required ProductDAO productDAO,
    required FileStorageService fileStorageService,
  }) : _productDAO = productDAO,
       _fileStorageService = fileStorageService;

  @override
  Future<void> add(ProductEntity product) async {
    // TODO: implement add
    try {
      final ProductModel productModel = ProductModel(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        quantity: product.quantity,
        image: product.image != null
            ? await _fileStorageService.saveFile(
                file: product.image!,
                folder: product.id,
              )
            : null,
      );

      return await _productDAO.insert(productModel);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    // TODO: implement delete
    try {
      await (_fileStorageService.deleteFiles(folder: id), _productDAO.delete(id)).wait;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductEntity>> getAll() async {
    // TODO: implement getAll
    try {
      final res = await _productDAO.findAll();
      final products = res.map((e) async => await _toEntity(model: e)).toList();
      return await products.wait;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductEntity?> getById(String id) async {
    // TODO: implement getById
    try {
      final res = await _productDAO.findById(id);
      return res != null ? await _toEntity(model: res) : null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(ProductEntity product) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<List<ProductEntity>> getRecipeProducts({required String id}) async {
    try {
      final res = await _productDAO.getProductsForRecipe(id);
      final products = res.map((e) async => await _toEntity(model: e));
      return await products.wait;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductEntity> _toEntity({required ProductModel model}) async {
    return ProductEntity(
      id: model.id,
      name: model.name,
      description: model.description,
      price: model.price,
      quantity: model.quantity,
      image: model.image != null
          ? await _fileStorageService.getFile(
              folder: model.id,
              fileName: model.image!,
            )
          : null,
    );
  }
}
