import 'dart:io';

import 'package:meal_planner/data/local/dao/product.dao.dart';
import 'package:meal_planner/data/local/models/product.model.dart';
import 'package:meal_planner/domain/abstract/repository.dart';

import 'package:meal_planner/domain/entities/product/product.entity.dart';
import 'package:meal_planner/service/file.storage.service.dart';
import 'package:meal_planner/utils/result.dart';

final class LocalProductRepository implements Repository<ProductEntity> {
  final ProductDAO _productDAO;
  final FileStorageService _fileStorageService;

  LocalProductRepository({
    required ProductDAO productDAO,
    required FileStorageService fileStorageService,
  }) : _productDAO = productDAO,
       _fileStorageService = fileStorageService;

  @override
  Future<Result<void>> add(ProductEntity product) async {
    // TODO: implement add
    try {
      late String image;
      if (product.image != null) {
        image = await _fileStorageService.saveFile(product.image!, product.id);
      }
      
      final ProductModel productModel = ProductModel(
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        quantity: product.quantity,
        image:image,
      );

      final res = await _productDAO.insert(productModel);
      return Result.ok(res);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> delete(String id) async {
    // TODO: implement delete
    try {
      print("Deleted Product with Id: $id");
      final res = await _productDAO.delete(id);
      await _fileStorageService.deleteFiles(id);
      return Result.ok(res);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<ProductEntity>>> getAll() async {
    // TODO: implement getAll
    try {
      final res = await _productDAO.findAll();
      final products = res.map((e) async {
        return ProductEntity(
          id: e.id,
          name: e.name,
          price: e.price,
          quantity: e.quantity,
          image: await _fileStorageService.getFile(e.id, e.image), 
          description: e.description,
        );
      }).toList();
      return Result.ok(await Future.wait(products));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<ProductEntity>> getById(String id) async {
    // TODO: implement getById
    try {
      final res = await _productDAO.findById(id);
      final ProductEntity product = ProductEntity(
        id: res!.id,
        name: res.name,
        description: res.description,
        price: res.price,
        quantity: res.quantity,
        image: await _fileStorageService.getFile(res.id, res.image),
      );
      return Future.value(Result.ok(product));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> update(ProductEntity product) async {
    // TODO: implement update
    try {
      late String image;
      if (product.image != null) {
       await _fileStorageService.deleteFiles(product.id);
      }
      image = await _fileStorageService.saveFile(product.image!, product.id);

      final res = await _productDAO.update(
        ProductModel(
          id: product.id,
          name: product.name,
          description: product.description,
          price: product.price,
          quantity: product.quantity,
          image: image,
        ),
      );
      return Future.value(Result.ok(res));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
