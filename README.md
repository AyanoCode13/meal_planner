# meal_planner

A new Flutter project.

Run tests - flutter test test/db/models --reporter expanded

# Model Tests
Product - flutter test test/db/models/model.product_test.dart --reporter expanded
Image - flutter test test/db/models/image.model_test.dart --reporter expanded
RecipeAndProduct - flutter test test/db/models/recipe_product_join_test.dart --reporter expanded

# View Tests
Recipe View - flutter test test/db/views/recipe.view_test.dart --reporter expanded
flutter packages pub run build_runner watch