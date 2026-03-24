// import 'package:flutter_test/flutter_test.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:meal_planner/data/local/repository/local/local.recipe.repository.dart';
// import 'package:meal_planner/domain/dto/product/create.product.dto.dart';
// import 'package:meal_planner/domain/dto/recipe/create.recipe.dto.dart';
// import 'package:meal_planner/domain/entities/entity.dart';
// import 'package:meal_planner/domain/entities/product/product.entity.dart';
// import 'package:mocktail/mocktail.dart';

// class MockLocalRecipeRepository extends Mock implements LocalRecipeRepository {}

// void main() {
//   group("Recipe Repository Tests", () {
//     final ingredient1 = ProductEntity.create(
//       dto: CreateProductDTO(
//         name: "Product1",
//         price: "1.2",
//         quantity: "2",
//         description: "",
//         image: XFile("no_image.png"),
//       ),
//     );

//     final ingredient2 = ProductEntity.create(
//       dto: CreateProductDTO(
//         name: "Product2",
//         price: "2.5",
//         quantity: "5",
//         description: "Product 2",
//         image: XFile("good_food.png"),
//       ),
//     );
//     final ingredients = [ingredient1, ingredient2];
//     final recipe1 = RecipeEntity.create(
//       dto: CreateRecipeDTO(
//         name: "Recipe 1",
//         ingredients: ingredients,
//         images: [XFile("recipe1.png")],
//       ),
//     );
//     final recipe2 = RecipeEntity.create(
//       dto: CreateRecipeDTO(
//         name: "Recipe 2",
//         ingredients: ingredients,
//         images: [XFile("recipe2.png")],
//       ),
//     );
//     final recipes = [recipe1, recipe2];

//     late MockLocalRecipeRepository repository;

//     setUpAll(() async {
//       registerFallbackValue(recipe1);
//       registerFallbackValue(<RecipeEntity>[]);
//     });
//     setUp(() async {
//       repository = MockLocalRecipeRepository();
//     });

//     test('should add a recipe', () async {
//       // Arrange – define what the mock returns
//       when(() => repository.add(any())).thenAnswer((_) async => {});

//       // Act
//       await repository.add(recipe1);
//       await repository.add(recipe2);
//       // Capture what was actually passed
//       final captured =
//           verify(() => repository.add(captureAny())).captured.first
//               as RecipeEntity;

//       // Assert on the captured data
//       expect(captured.name, 'Recipe 1');

//       expect(captured.description, '');
//     });

//     test('should add a many recipes', () async {
//       // Arrange – define what the mock returns
//       when(() => repository.addAll(any())).thenAnswer((_) async => {});

//       // Act
//       await repository.addAll(recipes);

//       // Capture the list that was passed
//       final captured =
//           verify(() => repository.addAll(captureAny())).captured.first
//               as List<RecipeEntity>;

//       // Assert
//       expect(captured.length, 2);
//     });
//   });
// }
