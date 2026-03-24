// test/helpers/database_test_helper.dart
import 'package:floor/floor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_planner/data/local/db/local.db.dart';
import 'package:meal_planner/data/sql/recipe.sql.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// your other imports...

Future<LocalDatabase> buildTestDatabase() async {
  return await $FloorLocalDatabase
      .inMemoryDatabaseBuilder()
      .addCallback(Callback(
       
        onCreate: (db, version) async {
          await db.execute('PRAGMA foreign_keys = ON');
          await db.execute(createRecipeView);
        },
        onOpen: (db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
      ))
      .build();
}

void initTestDatabase() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
}