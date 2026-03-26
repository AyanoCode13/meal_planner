import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meal_planner/data/local/models/models.dart';
import 'package:meal_planner/data/views/views.dart';
import 'package:meal_planner/domain/dto/recipe/create.recipe.dto.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';
import 'package:uuid/v4.dart';

part 'recipe.entity.freezed.dart';

@freezed
abstract class RecipeEntity with _$RecipeEntity {
  const RecipeEntity._();
  const factory RecipeEntity({
    required String id,
    required String name,
    @Default(0.0) double price,
    @Default(Duration.zero) Duration preparationTime,
    @Default("") String? description,
    @Default([]) List<ProductEntity> ingredients,
    @Default([]) List<File?> images,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RecipeEntity;

  factory RecipeEntity.create({
    required CreateRecipeDTO dto,
    DateTime? updatedAt,
  }) => RecipeEntity(
    id: const UuidV4().toString(),
    name: dto.name,
    createdAt: DateTime.timestamp(),
    updatedAt: updatedAt ?? DateTime.timestamp(),
  );

  factory RecipeEntity.withDetails({
    required RecipeView data,
    required List<File?> images,
    required List<ProductEntity> ingredients,
  }) => RecipeEntity(
    id: data.id,
    name: data.name,
    description: data.description,
    ingredients: ingredients,
    images: images,
    createdAt: data.createdAt,
    updatedAt: data.upatedAt,
  );
 
  factory RecipeEntity.fromModel(RecipeModel model) {
    // TODO: implement fromModel
    return RecipeEntity(
      id: model.id,
      name: model.name,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }


  factory RecipeEntity.fromView(RecipeView view) {
    // TODO: implement fromView
    return RecipeEntity(
      id: view.id,
      name: view.name,
      description: view.description,
      createdAt: view.createdAt,
      updatedAt: view.upatedAt,
    );
  }

  RecipeModel toModel() {
    return RecipeModel(
      name: name,
      description: description,
      preparationTime: preparationTime,
      createdAt: createdAt,
      updatedAt: updatedAt,
      id: id,
    );
  }
}
