import 'package:meal_planner/data/local/db/local.db.dart';
import 'package:meal_planner/domain/abstract/use_case.dart';
import 'package:meal_planner/domain/useCase/recipe.getById.dart';
import '../../data/local/repository/local/local.repository.dart';

import '../../domain/domain.dart';

import '../../ui/viewModels/view.models.dart';
import '../../service/service.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<List<SingleChildWidget>> get localProviders async {
  await LocalDatabase.initialize();
  final fileStorageService = FileStorageService();
  final productDAO = LocalDatabase.instance.productDAO;
  final recipeDAO = LocalDatabase.instance.recipeDAO;
  final recipesAndProductsDAO = LocalDatabase.instance.recipesAndProductsDAO;
  final imageDAO = LocalDatabase.instance.imageDAO;

  // Product Providers
  final LocalProductRepository localProductRepository = LocalProductRepository(
    productDAO: productDAO,
  );
  final getAllProductsUseCase = GetAllUseCase<ProductEntity>(
    repository: localProductRepository as Repository<ProductEntity>,
  );
  final getProductByIdUseCase = GetByIdUseCase<ProductEntity>(
    repository: localProductRepository as Repository<ProductEntity>,
  );
  final addProductUseCase = AddUseCase<ProductEntity>(
    repository: localProductRepository as Repository<ProductEntity>,
  );
  final updateProductUseCase = UpdateUseCase<ProductEntity>(
    repository: localProductRepository as Repository<ProductEntity>,
  );

  final deleteProductUseCase = DeleteUseCase<ProductEntity>(
    repository: localProductRepository as Repository<ProductEntity>,
  );

  // Recipe Providers
  final LocalRecipeRepository localRecipeRepsitory = LocalRecipeRepository(
    recipeDAO: recipeDAO,
    recipesAndProductsDAO: recipesAndProductsDAO,
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
    ChangeNotifierProvider(
      create: (context) => ProductViewModel(
        getAllUseCase: getAllProductsUseCase,
        getByIdUseCase: getProductByIdUseCase,
        addUseCase: addProductUseCase,
        updateUseCase: updateProductUseCase,
        deleteUseCase: deleteProductUseCase,
      ),
    ),

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

class GetAllRecipesUseCase {}
