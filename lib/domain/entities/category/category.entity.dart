
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'category.entity.freezed.dart';

@freezed
abstract class CategoryEntity with _$CategoryEntity {
  const factory CategoryEntity({
    required String id,
    required String name,
    @Default(null)
    File? image,
    required DateTime createAt,
    required DateTime updatedAt,
  }) = _CategoryEntity;


  factory CategoryEntity.create({ required String name, File? image }) {
    return CategoryEntity(
      id: const Uuid().v4(),
      name: name,
      image: image,
      createAt: DateTime.timestamp(),
      updatedAt: DateTime.timestamp()
    );
  }
}