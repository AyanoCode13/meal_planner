import 'dart:io';

import 'package:meal_planner/domain/dto/product/create.product.dto.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';
import 'package:meal_planner/utils/result.dart';
import 'package:mockito/mockito.dart';

import 'mocks.mocks.dart';

final file1 = File("file1.png");
final file2 = File("file2.png");
final files = [file1, file2];

// Products
final product1 = ProductEntity.create(
  dto: CreateProductDTO(name: "Product 1", images: files),
);
final product2 = ProductEntity.create(dto: CreateProductDTO(name: "Product 2"));

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
  ) assign,
}) {
  final repo = MockLocalProductRepository();
  final fileRepo = MockFileRepository();

  assign(repo, fileRepo);
}

