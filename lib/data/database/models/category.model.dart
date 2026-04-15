import 'package:floor/floor.dart';
@Entity(
  tableName: 'categories',
  primaryKeys: ['id'],
  indices: [
    Index(value: ['id'], unique: true),
    Index(value: ['name'], unique: true),
  ],
)
class CategoryModel {
  final String id;
  final String name;

  CategoryModel({required this.id, required this.name});

  
}