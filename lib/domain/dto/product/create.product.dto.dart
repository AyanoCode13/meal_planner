import 'dart:io';

import 'package:image_picker/image_picker.dart';

final class CreateProductDTO {
  final String _name;
  final double _price;
  final int _quantity;
  final String description;
  final List<XFile?> _images;

  CreateProductDTO({required String name, required double price, required int quantity, required this.description, required List<XFile?> images}) : _name = name, _price = price, _quantity = quantity, _images = images;

  

  String get name => _name;
  double get price => _price;
  int get quantity => _quantity;
  List<File?> get images => _images.map((e) => File(e!.path)).toList();
}
