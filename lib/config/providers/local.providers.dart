import 'package:meal_planner/data/local/db/local.db.dart';
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
    imageDAO: imageDAO,
    fileStorageService: fileStorageService,
  );
  final getAllProductsUseCase = GetAllProductsUseCase(
    repository: localProductRepository as Repository<ProductEntity>,
  );
  final getProductByIdUseCase = GetProductByIdUseCase(
    repository: localProductRepository as Repository<ProductEntity>,
  );
  final addProductUseCase = AddProductUseCase(
    repository: localProductRepository as Repository<ProductEntity>,
  );
  final updateProductUseCase = UpdateProductUseCase(
    repository: localProductRepository as Repository<ProductEntity>,
  );

  final deleteProductUseCase = DeleteProductUseCase(
    repository: localProductRepository as Repository<ProductEntity>,
  );

  // Recipe Providers
  final LocalRecipeRepository localRecipeRepsitory = LocalRecipeRepository(
    recipeDAO: recipeDAO,
    imageDAO: imageDAO,
    recipesAndProductsDAO: recipesAndProductsDAO,
    fileStorageService: fileStorageService,
  );
  final getAllRecipesUseCase = GetAllRecipesUseCase(
    repository: localRecipeRepsitory as Repository<RecipeEntity>,
  );
  final getRecipeByIdUseCase = GetRecipeByIdUseCase(
    repository: localRecipeRepsitory,
  );
  final addRecipeUseCase = AddRecipeUseCase(
    repository: localRecipeRepsitory as Repository<RecipeEntity>,
  );
  final updateRecipeUseCase = UpdateRecipeUseCase(
    repository: localRecipeRepsitory as Repository<RecipeEntity>,
  );
  final deleteRecipeUseCase = DeleteRecipeUseCase(
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
