import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';

final class CreateRecipeDTO {
  final String _name;
  final List<XFile?> _images;
  final String? _description;
  final Duration _preparationTime;
  final List<ProductEntity> _ingredients;


  CreateRecipeDTO({
    required String name, 
    required List<XFile?> images, 
    String? description, 
    Duration? preparationTime,
    required List<ProductEntity> ingredients, 
  }) : _name = name, _images = images, _description = description, _preparationTime = preparationTime ?? Duration.zero, _ingredients = ingredients;



  String get name => _name;
  double get price =>
      _ingredients.fold(0.0, (sum, ingredient) => sum + ingredient.price);
  List<File?> get images => _images.map((e) => File(e!.path)).toList();
  String get description => _description ?? "";
  List<ProductEntity> get ingredients =>_ingredients;
  String get preparationTime => _preparationTime.toString();
}
