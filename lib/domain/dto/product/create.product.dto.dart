import 'dart:io';

import 'package:image_picker/image_picker.dart';

final class CreateProductDTO {
  final String _name;
  final String _description;
  final double _price;
  final int _quantity;
  final List<XFile> _files;

  CreateProductDTO({required String name, String description = "", String price = '0.0', String quantity = "1", List<XFile> files = const []}) : 
  _name = name, 
  _description = description, 
  _price = double.tryParse(price) ?? 0.0, 
  _quantity = int.tryParse(quantity) ?? 1,
  _files = files;

  String get name => _name;
  String get description => _description;
  double get price => _price;
  int get quantity => _quantity;
  List<File> get files => _files.map((e)=> File(e.path)).toList();


 
}
