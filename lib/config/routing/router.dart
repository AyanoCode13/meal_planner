import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/config/routing/routes/paths.dart';
import 'package:meal_planner/config/routing/routes/product.routes.dart';
import 'package:meal_planner/config/routing/routes/recipe.routes.dart';
import 'package:meal_planner/domain/useCase/product/add.product.useCase.dart';
import 'package:meal_planner/domain/useCase/product/delete.product.useCase.dart';
import 'package:meal_planner/domain/useCase/product/getAll.useCase.dart';
import 'package:meal_planner/domain/useCase/product/getById.useCase.dart';
import 'package:meal_planner/domain/useCase/product/update.product.useCase.dart';
import 'package:meal_planner/ui/navigation/bottom.navigation.dart';
import 'package:meal_planner/ui/screens/product/add/screen.dart';
import 'package:meal_planner/ui/screens/product/all/screen.dart';
import 'package:meal_planner/ui/screens/product/id/screen.dart';
import 'package:meal_planner/ui/viewModels/product.viewModel.dart';
import 'package:provider/provider.dart';

import '../../ui/screens/recipe/all/screen.dart';

Widget get _productViewAllScreen => ChangeNotifierProvider(
  create: (context) => ProductViewModel(
    getAllUseCase: context.read<GetAllProductsUseCase>(),
    getByIdUseCase: context.read<GetByIdProductUseCase>(),
    addUseCase: context.read<AddProductUseCase>(),
    updateUseCase: context.read<UpdateProductUseCase>(),
    deleteUseCase: context.read<DeleteProductUseCase>(),
  ),
  child: ProductViewAllScreen(),
);

GoRouter router() => GoRouter(
  initialLocation: ProductRoutes.all,
  routes: [
    ShellRoute(
      builder: (context, _, child) => AppBottomNavigation(child: child),
      routes: [
        GoRoute(
          path: ProductRoutes.all,
          builder: (context, state) => _productViewAllScreen,
          routes: [
            GoRoute(
              path: Paths.add,
              builder: (context, _) => AddProductScreen(),
            ),
            GoRoute(
              path: Paths.view,
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return ViewAndEditProductScreen();
              },
            ),
          ],
        ),
        GoRoute(
          path: RecipeRoutes.all,
          builder: (context, state) => RecipesViewAllScreen(),
        ),
      ],
    ),
  ],
);
