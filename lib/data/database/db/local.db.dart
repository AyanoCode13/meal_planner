import 'dart:async';

import 'package:floor/floor.dart';
import 'package:meal_planner/data/database/dao/joins/categories_and_products.dao.dart';
import 'package:meal_planner/data/database/dao/image.dao.dart';
import 'package:meal_planner/data/database/dao/recipe.dao.dart';
import 'package:meal_planner/data/database/sql/recipe.sql.dart';
import 'package:meal_planner/utils/converter.dart';
import 'package:meal_planner/data/database/views/recipe.view.dart';
import '../dao/dao.dart';
import '../models/category.model.dart';
import '../models/joins/categories_and_products.dart';
import '../models/models.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'local.db.g.dart';

const _entities = [
  ProductModel,
  RecipeModel,
  ImageModel,
  CategoryModel,
  RecipeProductModel,
  CategoryProductModel,
];
const _views = [RecipeView];

@TypeConverters([DateTimeConverter, DurationConverter])
@Database(version: 1, entities: _entities, views: _views)
abstract class LocalDatabase extends FloorDatabase {
  ProductDAO get productDAO;
  RecipeDAO get recipeDAO;
  ImageDAO get imageDAO;
  RecipesAndProductsDAO get recipesAndProductsDAO;
  CategoriesAndProductsDAO get categoriesAndProductsDAO;
  static late LocalDatabase _instance;
  static LocalDatabase get instance => _instance;
  static Future<void> initialize() async {
    _instance = await $FloorLocalDatabase
        .databaseBuilder('app_db_v8.db')
        .addCallback(
          Callback(
            onCreate: (db, version) async {
              await (
                db.execute('PRAGMA foreign_keys = ON'),

                db.execute(createRecipeView),
              ).wait;
            },
            onOpen: (db) async {
              await db.execute('PRAGMA foreign_keys = ON');
            },
          ),
        )
        .build();
  }
}
