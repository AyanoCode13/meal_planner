import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:meal_planner/domain/dto/product/create.product.dto.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';
import 'package:meal_planner/domain/useCase/product/add.useCase.dart';
import 'package:meal_planner/domain/useCase/product/delete.useCase.dart';
import 'package:meal_planner/domain/useCase/product/getAll.useCase.dart';
import 'package:meal_planner/domain/useCase/product/getById.useCase.dart';
import 'package:meal_planner/utils/command.dart';
import 'package:meal_planner/utils/result.dart';

final class ProductViewModel extends ChangeNotifier {
  final AddProductUseCase _addProductUseCase;
  final GetAllProductsUseCase _getAllProductsUseCase;
  final DeleteProductUseCase _deleteProductUseCase;
  final GetByIdUseCase _getByIdUseCase;

  ProductViewModel({
    required AddProductUseCase addProductUseCase,
    required GetAllProductsUseCase getAllProductsUseCase,
    required DeleteProductUseCase deleteProductUseCase,
    required GetByIdUseCase getByIdUseCase,
  }) : _addProductUseCase = addProductUseCase,
       _getAllProductsUseCase = getAllProductsUseCase,
       _deleteProductUseCase = deleteProductUseCase,
       _getByIdUseCase = getByIdUseCase {
    load = BasicCommand(_load)..execute();
    add = ComplexCommand(_add);
    delete = ComplexCommand(_delete);
    getById = ComplexCommand(_getById);
    search = ComplexCommand(_search);
  }
  final Logger _logger = Logger();

  late List<ProductEntity> _products;
  List<ProductEntity> get products => _products;

  late List<ProductEntity> _searchedProducts = [];
  List<ProductEntity> get searchedProducts => _searchedProducts;

  late ProductEntity? _product;
  ProductEntity? get product => _product;

  late final BasicCommand load;
  late final ComplexCommand<void, CreateProductDTO> add;
  late final ComplexCommand<void, ProductEntity> delete;
  late final ComplexCommand<void, String> getById;
  late final ComplexCommand<void, String> search;

  List<Command> get commands => [load, add, delete, getById];
  
    Future<Result<void>> _search(String query) async {
    try {
      final res = await _getAllProductsUseCase.call(input: null);
      switch (res) {
        case Ok<List<ProductEntity>>():
          _searchedProducts = res.value;
        case Error<List<ProductEntity>>():
          Result.error(res.error);
      }
      return res;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _load() async {
    try {
      final res = await _getAllProductsUseCase.call(input: null);
      switch (res) {
        case Ok<List<ProductEntity>>():
          _products = res.value;
        case Error<List<ProductEntity>>():
          Result.error(res.error);
      }
      return res;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _getById(String id) async {
    try {
      final res = await _getByIdUseCase.call(input: id);
      switch (res) {
        case Ok<ProductEntity?>():
         _product = res.value;
        case Error<ProductEntity?>():
          Result.error(res.error);
      }
      return res;
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _add(CreateProductDTO data) async {
    try {
      final res = await _addProductUseCase.call(input: data);
      _logger.i(res);
      switch (res) {
        case Ok<ProductEntity>():
          await _load();
          return Result.ok(null);
        case Error<ProductEntity>():
          return Result.error(res.error);
      }
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _delete(ProductEntity product) async {
    try {
      final res = await _deleteProductUseCase.call(input: product.id);
      await _load();
      switch (res) {
        case Ok<void>():
          return Result.ok(null);
        case Error<void>():
          return Result.error(res.error);
      }
    } finally {
      notifyListeners();
    }
  }
}
