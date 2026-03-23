// test/recipe_ingredients_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:meal_planner/data/local/db/local.db.dart';
import 'package:meal_planner/data/local/models/models.dart';
import 'package:meal_planner/data/views/recipe.view.dart';

import '../../test.setup.dart';

void main() {
  // initialize sqflite for testing environment
  initTestDatabase();

  group('Product Model Test', () {
    late LocalDatabase database;
    Logger _logger = Logger();
    setUpAll(() async {
      await _logger.init;
      database = await buildTestDatabase();
    });
    tearDownAll(() async => await database.close());
    

    final product = ProductModel(
      id: "1",
      name: "Product 1",
      description: "",
      price: 1.2,
      quantity: 2,
      image: null,
    );

    void printRsult(List<dynamic> data){
      for(dynamic item in data){
        
      }
    }
  

    test('Can insert a product', () async {
      await database.productDAO.insert(product);
      final res = await database.productDAO.findAll();
      expect(res.length, equals(1));
      expect(res[0].name, "Product 1");
    });
    test('Can update a product', () async {
      final updatedProduct = ProductModel(
        id: product.id,
        name: "Product 2",
        description: "Updated",
        price: 1.4,
        quantity: 3,
        image: null,
      );

      await database.productDAO.update(updatedProduct);
      final res = await database.productDAO.findById(product.id);
    
      expect(res, isNotNull);
      expect(res!.id, product.id);
      expect(res.name, "Product 2");
      expect(res.description, "Updated");
      expect(res.quantity, equals(3));
     
    });

    test('Can delete a product', () async {
      // await database.productDAO.delete(product.id);
      // final res = await database.productDAO.findAll();
      // expect(res.length, equals(0));
    });

    test("testing database views",() async {
      final res = await database.recipeDAO.getAll();
      for(Recipe recipe in res){
        _logger.i(recipe);
      }
    });
    
  });
}
