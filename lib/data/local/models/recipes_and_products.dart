// recipe_product_join.dart
import 'package:floor/floor.dart';
import 'package:meal_planner/data/local/models/product.model.dart';
import 'package:meal_planner/data/local/models/recipe.model.dart';

@Entity(
  tableName: 'recipe_product_join',
  primaryKeys: ['recipeId', 'productId'],  // composite primary key
  foreignKeys: [
    ForeignKey(
      childColumns: ['recipeId'],
      parentColumns: ['id'],
      entity: RecipeModel,
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
    Index(value: ['recipeId']),
    Index(value: ['productId']),
  ],
)
final class RecipeProductModel {
 
  final String recipeId;
  final String productId;
  final int quantity;

  RecipeProductModel({required this.recipeId, required this.productId, required this.quantity});
}