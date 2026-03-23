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

  group('Recipe Ingredients Tests', () {
    late LocalDatabase database;
    Logger _logger = Logger();
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
    setUpAll(() async => database = await buildTestDatabase());
    setUp(() async {
       await (
        database.productDAO.insertMany(products),
        database.recipeDAO.insertMany(recipes),
        database.recipesAndProductsDao.insertMany(joins),
      ).wait;
    });
    tearDownAll(() async => await database.close());

    test(
      'insert 5 products, 3 recipes, and get ingredients for recipe 1',
      () async {
        // ─────────────────────────────────────────
        // ARRANGE — insert test data
        // ─────────────────────────────────────────

        // 1. insert 5 products

        await database.productDAO.insertMany(products);

        // 2. insert 3 recipes

        await database.recipeDAO.insertMany(recipes);

        // 3. link products to recipes via junction table

        await database.recipesAndProductsDao.insertMany(joins);

        // ─────────────────────────────────────────
        // ACT — run the query
        // ─────────────────────────────────────────
        final ingredients = await database.productDAO.getProductsForRecipe("1");

        // ─────────────────────────────────────────
        // ASSERT — verify the results
        // ─────────────────────────────────────────

        // should return exactly 3 ingredients for recipe 1
        expect(ingredients.length, 3);

        // should only contain Tomato, Pasta, Garlic (recipe 1's ingredients)
        final names = ingredients.map((p) => p.name).toList();
        expect(names, containsAll(['Tomato', 'Pasta', 'Garlic']));

        // should NOT contain ingredients from other recipes
        expect(names, isNot(contains('Cheese')));
        expect(names, isNot(contains('Olive Oil')));

        // verify specific product details
        final tomato = ingredients.firstWhere((p) => p.name == 'Tomato');
        expect(tomato.price, 1.99);
        expect(tomato.quantity, 150);
      },
    );

    test("Should only delete the recipe but not the products", () async {
      await database.recipeDAO.delete("1");
      final res = await database.productDAO.findAll();
     
      expect(res.length, equals(5));
    });
    test("Should only delete the product but not the recipe", () async {
      await database.productDAO.delete("1");

      final products = await database.productDAO.findAll();
      final recipes = await database.recipeDAO.getAll();

      expect(products.length, equals(4));
      expect(recipes.length, equals(3));
    });

    test("if the product price is modified the recipe total will be modified", (){

    });

     test("testing database views",() async {
      final res = await database.recipeDAO.getAll();
      for(Recipe recipe in res){
       print({recipe.name, recipe.total});
      }
    });
  });
}
