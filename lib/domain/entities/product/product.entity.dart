import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meal_planner/data/local/models/product.model.dart';
import 'package:meal_planner/domain/dto/product/create.product.dto.dart';
import 'package:uuid/uuid.dart';

part 'product.entity.freezed.dart';

@freezed
abstract class ProductEntity with _$ProductEntity {
  const ProductEntity._();
  const factory ProductEntity({
    required String id,
    @Assert('name.isNotEmpty', 'name cannot be empty')
    required String name,
    required String? description,
    @Assert('price >= 0', 'price cannot be negative')
    required double price,
    @Assert('quantity >= 0', 'quantity cannot be negative')
    required int quantity,
    required File? image,
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
      image: dto.image
    );
  }

}