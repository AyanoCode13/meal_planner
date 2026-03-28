import 'package:meal_planner/domain/entities/product/product.entity.dart';

abstract final class ProductRoutes {
  static const String viewAll = '/products';
  static String view(ProductEntity product) => "/products/${product.id}";
  static const String add = '/products/add';
}


