import 'package:meal_planner/data/local/db/local.db.dart';
import '../../data/local/repository/local/local.repository.dart';

import '../../domain/domain.dart';

import '../../ui/viewModels/view.models.dart';
import '../../service/service.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


Future<List<SingleChildWidget>> get localProviders async {
  await LocalDatabase.initialize();
  // Product Providers
  final LocalProductRepository localProductRepository = LocalProductRepository(
    productDAO: LocalDatabase.instance.productDAO,
    fileStorageService: FileStorageService(),
  );
  final AddProductUseCase addProductUseCase = AddProductUseCase(
    repository: localProductRepository as Repository<ProductEntity>,
  );
  final GetAllProductsUseCase getAllProductsUseCase = GetAllProductsUseCase(
    repository: localProductRepository as Repository<ProductEntity>,
  );
  final DeleteProductUseCase deleteProductUseCase = DeleteProductUseCase(
    repository: localProductRepository as Repository<ProductEntity>,
  );
  final GetByIdUseCase getByIdUseCase = GetByIdUseCase(
    repository: localProductRepository as Repository<ProductEntity>,
  );

  // Recipe Providers
  final LocalRecipeRepository localRecipeRepsitory = LocalRecipeRepository(
    recipeDAO: LocalDatabase.instance.recipeDAO,
    productDAO: LocalDatabase.instance.productDAO,
    recipesAndProductsDAO: LocalDatabase.instance.recipesAndProductsDao,
    fileStorageService: FileStorageService(),
  );
  final AddRecipeUseCase addRecipeUseCase = AddRecipeUseCase(
    repository: localRecipeRepsitory as Repository<RecipeEntity>,
  );
  final GetAllRecipesUseCase getAllRecipesUseCase = GetAllRecipesUseCase(
    repository: localRecipeRepsitory as Repository<RecipeEntity>,
  );
  final GetRecipeByIdUseCase getRecipeByIdUseCase = GetRecipeByIdUseCase(
    recipeRepsitory: localRecipeRepsitory,
    productRepository: localProductRepository
  );

  
  return [
    ChangeNotifierProvider(
      create: (context) => ProductViewModel(
        addProductUseCase: addProductUseCase,
        getAllProductsUseCase: getAllProductsUseCase,
        deleteProductUseCase: deleteProductUseCase,
        getByIdUseCase: getByIdUseCase,
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => RecipeViewModel(
        addRecipeUseCase: addRecipeUseCase,
        getAllRecipesUseCase: getAllRecipesUseCase,
        getRecipeByIdUseCase: getRecipeByIdUseCase
      ),
    ),
  ];
  
}
