// recipe_product_join.dart
import 'package:floor/floor.dart';
import 'package:meal_planner/data/database/models/category.model.dart';
import 'package:meal_planner/data/database/models/product.model.dart';

@Entity(
  tableName: 'category_product_join',
  primaryKeys: ['category', 'productId'],  // composite primary key
  foreignKeys: [
    ForeignKey(
      childColumns: ['categoryId'],
      parentColumns: ['id'],
      entity: CategoryModel,
      onDelete: ForeignKeyAction.cascade
     
    ),
    ForeignKey(
      childColumns: ['productId'],
      parentColumns: ['id'],
      entity: ProductModel,
      onDelete: ForeignKeyAction.cascade
      
    ),
  ],
  indices: [
    Index(value: ['categoryId']),
    Index(value: ['productId']),
  ],
)
class CategoryProductModel {
 
  final String categoryId;
  final String productId;
  final int quantity;

  CategoryProductModel({required this.categoryId, required this.productId, required this.quantity});
}