import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meal_planner/data/local/models/models.dart';
import 'package:meal_planner/domain/dto/product/create.product.dto.dart';
import 'package:uuid/v4.dart';

part 'product.entity.freezed.dart';

@freezed
abstract class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    required String id,
    required String name,
    @Default("")
    String? description,
    @Default(0.0) double price,
    @Default(1) int quantity,
    @Default([]) List<File?> images,
  }) = _ProductEntity;

  factory ProductEntity.create({required CreateProductDTO dto}) {
    return ProductEntity(
      id: const UuidV4().toString(),
      name: dto.name,
    );
  }

  factory ProductEntity.fromModel({required ProductModel data}) {
    return ProductEntity(
      id: data.id,
      name: data.name,
    );
  }
}
