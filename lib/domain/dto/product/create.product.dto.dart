import 'dart:io';

final class CreateProductDTO {
  final String name;
  List<File> files = [];

  CreateProductDTO({
    required this.name, 
    List<File> images = const []
  })
    : files = images;
}
