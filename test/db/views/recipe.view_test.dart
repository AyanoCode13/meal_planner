import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:meal_planner/data/local/db/local.db.dart';
import 'package:meal_planner/data/local/models/product.model.dart';
import 'package:meal_planner/data/local/models/recipe.model.dart';
import 'package:meal_planner/data/local/models/recipes_and_products.dart';
import 'package:meal_planner/data/views/recipe.view.dart';

import '../../test.setup.dart';

void main() {
  late LocalDatabase database;
  final Logger logger = Logger();
   final products = [
      ProductModel(
        id: "1",
        name: 'Tomato',
        description: "",
        image: "",
        price: 1.99,
        quantity: 150,
      ),
      ProductModel(
        id: "2",
        name: 'Pasta',
        description: "",
        image: "",
        price: 2.49,
        quantity: 200,
      ),
      ProductModel(
        id: "3",
        name: 'Cheese',
        description: "",
        image: "",
        price: 4.99,
        quantity: 80,
      ),
      ProductModel(
        id: "4",
        name: 'Olive Oil',
        description: "",
        image: "",
        price: 7.99,
        quantity: 60,
      ),
      ProductModel(
        id: "5",
        name: 'Garlic',
        description: "",
        image: "",
        price: 0.99,
        quantity: 300,
      ),
    ];
    final recipes = [
      RecipeModel(
        id: "1",
        name: 'Pasta al Pomodoro',
        description: 'Classic Italian pasta',
        
        image: "",
        preparationTime: "",
      ),
      RecipeModel(
        id: "2",
        name: 'Garlic Bread',
        description: 'Crispy garlic bread',
       
        image: "",
        preparationTime: "",
      ),
      RecipeModel(
        id: "3",
        name: 'Cheese Pasta',
        description: 'Creamy cheese pasta',
        
        image: "",
        preparationTime: "",
      ),
    ];
    final joins = [
      // Recipe 1: Pasta al Pomodoro → Tomato, Pasta, Garlic
      RecipeProductModel(recipeId: "1", productId: "1", quantity: 200),
      RecipeProductModel(recipeId: "1", productId: "2", quantity: 250),
      RecipeProductModel(recipeId: "1", productId: "5", quantity: 15),

      // Recipe 2: Garlic Bread → Garlic, Cheese, Olive Oil
      RecipeProductModel(recipeId: "2", productId: "5", quantity: 10),
      RecipeProductModel(recipeId: "2", productId: "3", quantity: 50),
      RecipeProductModel(recipeId: "2", productId: "4", quantity: 30),

      // Recipe 3: Cheese Pasta → Pasta, Cheese, Olive Oil, Garlic
      RecipeProductModel(recipeId: "3", productId: "2", quantity: 300),
      RecipeProductModel(recipeId: "3", productId: "2", quantity: 100),
      RecipeProductModel(recipeId: "3", productId: "2", quantity: 20),
      RecipeProductModel(recipeId: "3", productId: "2", quantity: 5),
    ];
    setUpAll(() async {
    await logger.init;
    database = await buildTestDatabase();
  });
    setUp(() async {
       await (
        database.productDAO.insertMany(products),
        database.recipeDAO.insertMany(recipes),
        database.recipesAndProductsDao.insertMany(joins),
      ).wait;
    });
  tearDownAll(() async => await database.close());

   test("testing database views",() async {
      final res = await database.recipesAndProductsDao.findAll();
      for(RecipeProductModel data in res){
        print({ data.productId, data.recipeId});
      }
       final res2 = await database.recipeDAO.getAll();
       for(Recipe data in res2){
        print({ data.name, data.total});
      }
      
    });
}
