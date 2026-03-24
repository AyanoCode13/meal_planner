import 'package:floor/floor.dart';
import 'package:meal_planner/domain/domain.dart';


@Entity(
  tableName: 'products',
  primaryKeys: ['id'],
  indices: [
    Index(value: ['id'], unique: true),
    Index(value: ['name'], unique: true),
  ],
)
class ProductModel {
  final String id;
  final String name;
  final String? description;
  final double price;
  final int quantity;


  const ProductModel({required this.id, required this.name, required this.description, required this.price, required this.quantity});
  
  factory ProductModel.fromEntity({ required ProductEntity data}){
    return ProductModel(id: data.id, name: data.name, description: data.description, price: data.price, quantity: data.quantity);
  }

  
}
