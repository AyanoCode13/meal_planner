import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meal_planner/domain/dto/recipe/create.recipe.dto.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';
import 'package:uuid/uuid.dart';

part 'recipe.entity.freezed.dart';

@freezed
abstract class RecipeEntity with _$RecipeEntity {
  const RecipeEntity._();
  const factory RecipeEntity({
    required String id,
    required String name,
    required double price,
    required String preparationTime,
    required String? description,
    required List<ProductEntity> ingredients,
    required File? image,
  }) = _RecipeEntity;

  factory RecipeEntity.create({ required CreateRecipeDTO dto}) => RecipeEntity(
    id: const Uuid().v4(),
    name: dto.name,
    price: dto.price,
    preparationTime: dto.preparationTime,
    description: dto.description,
    ingredients: dto.ingredients,
    image: dto.image,
  );
  
  


}