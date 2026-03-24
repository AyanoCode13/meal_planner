import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meal_planner/data/local/models/models.dart';
import 'package:meal_planner/domain/dto/product/create.product.dto.dart';
import 'package:uuid/uuid.dart';

part 'product.entity.freezed.dart';

@freezed
abstract class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    required String id,
    required String name,
    required String? description,
    required double price,
    required int quantity,
    required List<File?> images,
  }) = _ProductEntity;

  factory ProductEntity.create({
    required CreateProductDTO dto,
  }) {
    return ProductEntity(
      id: const Uuid().v4(),
      name: dto.name,
      description: dto.description,
      price: dto.price,
      quantity: dto.quantity,
      images: [dto.image]
    );
  }

  factory ProductEntity.fromModel({ required ProductModel data, required List<File?> images }){
    return ProductEntity(
      id: data.id,
      name: data.name,
      description: data.description,
      price: data.price,
      quantity: data.quantity,
      images: images
    );
  }
  

}