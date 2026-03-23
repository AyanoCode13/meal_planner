import 'package:floor/floor.dart';


@Entity(
  tableName: 'products',
  primaryKeys: ['id'],
  indices: [
    Index(value: ['id'], unique: true),
    Index(value: ['name'], unique: true),
  ],
)
final class ProductModel {
  final String id;
  final String name;
  final String? description;
  final double price;
  final int quantity;
  final String? image;

  const ProductModel({required this.id, required this.name, required this.description, required this.price, required this.quantity, required this.image});

  
}
