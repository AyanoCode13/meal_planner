import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meal_planner/data/database/models/models.dart';
import 'package:meal_planner/domain/dto/product/create.product.dto.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

part 'product.entity.freezed.dart';

@freezed
abstract class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    required String id,
    required String name,
    @Default("New Prodict")
    String? description,
    @Default(0.0) double price,
    @Default(1) int quantity,
    @Default([]) List<File> images,
    required DateTime expiresAt,
    required DateTime createAt,
    required DateTime updatedAt,

  }) = _ProductEntity;

  factory ProductEntity.create({required CreateProductDTO dto}) {
    return ProductEntity(
      id: const Uuid().v4(),
      name: dto.name,
      description: dto.description,
      price: dto.price,
      quantity: dto.quantity,
      images: dto.files,
      expiresAt: DateTime.now().add(Duration(days: 7)),
      createAt: DateTime.timestamp(),
      updatedAt: DateTime.timestamp()
    );
  }

  factory ProductEntity.fromModel({required ProductModel data}) {
    return ProductEntity(
      id: data.id,
      name: data.name,
      description: data.description,
      price: data.price,
      quantity: data.quantity,
      expiresAt: data.expiresAt,
      createAt: data.createdAt,
      updatedAt: data.updatedAt
    );
  }
}
