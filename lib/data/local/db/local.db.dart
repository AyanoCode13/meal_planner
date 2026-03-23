import 'dart:async';

import 'package:floor/floor.dart';
import 'package:meal_planner/data/views/recipe.view.dart';
import '../dao/dao.dart';
import '../models/models.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../../triggers/triggers.dart';

part 'local.db.g.dart';

const _entities = [ProductModel, RecipeModel, RecipeProductModel];
const _views = [Recipe];

@Database(version: 1, entities: _entities, views: _views)
abstract class LocalDatabase extends FloorDatabase {
  ProductDAO get productDAO;
  RecipeDAO get recipeDAO;
  RecipesAndProductsDAO get recipesAndProductsDao;
  static late LocalDatabase _instance;
  static LocalDatabase get instance => _instance;
  static Future<void> initialize() async {
    _instance = await $FloorLocalDatabase
        .databaseBuilder('app_db_v19.db')
        .addCallback(
          Callback(
            onCreate: (db, version) async {
              await (
                db.execute('PRAGMA foreign_keys = ON'),
                db.execute(updateRecipePriceOnProductUpdate),
                db.execute(createRecipeView)
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
