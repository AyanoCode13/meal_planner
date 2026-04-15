import 'package:meal_planner/data/database/db/local.db.dart';
import 'package:meal_planner/data/database/repository/joins/local.category_and_product.repository.dart';
import 'package:meal_planner/data/database/repository/local.file.repository.dart';
import 'package:meal_planner/data/database/repository/local.product.repository.dart';
import 'package:meal_planner/data/database/repository/local.recipe.repository.dart';
import 'package:meal_planner/domain/abstract/repository.dart';
import 'package:meal_planner/domain/abstract/use_case.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';
import 'package:meal_planner/domain/entities/recipe/recipe.entity.dart';
import 'package:meal_planner/domain/useCase/product/add.product.useCase.dart';
import 'package:meal_planner/domain/useCase/product/delete.product.useCase.dart';
import 'package:meal_planner/domain/useCase/product/getAll.useCase.dart';
import 'package:meal_planner/domain/useCase/product/getById.useCase.dart';
import 'package:meal_planner/domain/useCase/product/update.product.useCase.dart';
import 'package:meal_planner/domain/useCase/recipe.getById.dart';
import 'package:meal_planner/service/file.storage.service.dart';
import 'package:meal_planner/ui/viewModels/recipe.viewModel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../data/database/repository/joins/local.recipe_and_product.repository.dart';

Future<List<SingleChildWidget>> get localProviders async {
  await LocalDatabase.initialize();
  final db = LocalDatabase.instance;
  final fileStorageService = FileStorageService();
  final localFileRepository = LocalFileRepository(
    imageDAO: db.imageDAO,
    fileStorageService: fileStorageService,
  );

  // Join Repositories
  final localCategoriesAndProductsRepository = CategoriesAndProductsRepository(categoriesAndProductsDAO: db.categoriesAndProductsDAO);
  final localRecipesAndProductsRepository = RecipesAndProductsRepository(recipesAndProductsDAO: db.recipesAndProductsDAO);

  // Product Providers
  final LocalProductRepository localProductRepository = LocalProductRepository(
    productDAO: db.productDAO,
  );
  final getAllProductsUseCase = GetAllProductsUseCase(
    repository: localProductRepository as Repository<ProductEntity>,
    fileRepository: localFileRepository,
  );
  final getProductByIdUseCase = GetByIdProductUseCase(
    repository: localProductRepository as Repository<ProductEntity>,
    fileRepository: localFileRepository,
  );
  final addProductUseCase = AddProductUseCase(
    categoriesAndProductsRepository: localCategoriesAndProductsRepository,
    repository: localProductRepository as Repository<ProductEntity>,
    fileRepository: localFileRepository,
  );
  final updateProductUseCase = UpdateProductUseCase(
    repository: localProductRepository as Repository<ProductEntity>,
    fileRepository: localFileRepository,
  );

  final deleteProductUseCase = DeleteProductUseCase(
    repository: localProductRepository as Repository<ProductEntity>,
    fileRepository: localFileRepository,
  );

  // Recipe Providers
  final LocalRecipeRepository localRecipeRepsitory = LocalRecipeRepository(
    recipeDAO: db.recipeDAO,
    recipesAndProductsDAO: db.recipesAndProductsDAO,
  );
  final getAllRecipesUseCase = GetAllUseCase<RecipeEntity>(
    repository: localRecipeRepsitory,
  );
  final getRecipeByIdUseCase = GetRecipeByIdUseCase(
    productRepository: localProductRepository,
    recipeRepository: localRecipeRepsitory,
  );
  final addRecipeUseCase = AddUseCase<RecipeEntity>(
    repository: localRecipeRepsitory,
  );
  final updateRecipeUseCase = UpdateUseCase<RecipeEntity>(
    repository: localRecipeRepsitory as Repository<RecipeEntity>,
  );
  final deleteRecipeUseCase = DeleteUseCase<RecipeEntity>(
    repository: localRecipeRepsitory as Repository<RecipeEntity>,
  );

  return [
    Provider.value(value: getAllProductsUseCase),
    Provider.value(value: getProductByIdUseCase),
    Provider.value(value: addProductUseCase),
    Provider.value(value: updateProductUseCase),
    Provider.value(value: deleteProductUseCase),

    ChangeNotifierProvider(
      create: (context) => RecipeViewModel(
        getAllUseCase: getAllRecipesUseCase,
        getByIdUseCase: getRecipeByIdUseCase,
        addUseCase: addRecipeUseCase,
        updateUseCase: updateRecipeUseCase,
        deleteUseCase: deleteRecipeUseCase,
      ),
    ),
  ];
}
