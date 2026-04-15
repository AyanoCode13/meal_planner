import 'dart:io';

import 'package:meal_planner/data/database/models/image.model.dart';
import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:meal_planner/domain/domain.dart';
import 'package:meal_planner/domain/dto/product/create.product.dto.dart';
import 'package:meal_planner/utils/result.dart';
import 'package:mockito/mockito.dart';

import 'mocks.mocks.dart';

final file1 = File("file1.png");
final file2 = File("file2.png");
final files = [file1, file2];

// Products
final product1 = ProductEntity.create(
  dto: CreateProductDTO(name: "Product 1"),
);
final product2 = ProductEntity.create(dto: CreateProductDTO(name: "Product 2"));

List<ImageModel> images = files
    .map((e) => ImageModel(id: product1.id, url: e.path))
    .toList();

void registerCommonDummies() {
  // Success
  provideDummy<Result<void>>(Result.ok(null));
  provideDummy<Result<List<String>>>(Result.ok([]));
  provideDummy<Result<List<ProductEntity>>>(Result.ok([]));

  // Error
  provideDummy<Result<void>>(Result.error(Exception()));
  provideDummy<Result<List<String>>>(Result.error(Exception()));
  provideDummy<Result<List<ProductEntity>>>(Result.error(Exception()));
}

void setupMocks({
  required void Function(
    MockLocalProductRepository repo,
    MockFileRepository fileRepo,
  )
  assign,
}) {
  final repo = MockLocalProductRepository();
  final fileRepo = MockFileRepository();

  assign(repo, fileRepo);
}

// Stubs
void addProductStub(MockLocalProductRepository mockProductRepository) {
  when(mockProductRepository.add(any)).thenAnswer((_) async => Result.ok(null));
}

void updateProductStub(MockLocalProductRepository mockProductRepository) {}

// 1. Base stub — holds the input
abstract class Stub<I> {
  final I input;
  Stub({required this.input});

  void execute(); // subclasses define the when().thenAnswer() wiring
}

// 2. Success/Error variants — constrain the output type


// 3. Concrete stubs for a specific repository method (e.g. add)
abstract class AddStubSuccess<I, O> extends Stub<I> {
  final Repository<I> _repository;
  final Result<O> _result;

  AddStubSuccess({
    required Repository<I> repository,
    required Result<O> result, 
    required super.input,
  })  : _repository = repository,
        _result = result;
  @override
  void execute() {
    when(_repository.add(input)).thenAnswer((_) async => _result);
  }
}

abstract class AddStubError<I, O> extends Stub<I> {
  final Repository<I> _repository;
  final Error<O> _failure;

  AddStubError({
    required Repository<I> repository,
    required Error<O> failure,
    required I data,
  })  : _repository = repository,
        _failure = failure, super(input: data);

  @override
  void execute() {
    when(_repository.add(input)).thenAnswer((_) async => _failure);
  }
}




