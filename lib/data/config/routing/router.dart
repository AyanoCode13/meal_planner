import 'package:go_router/go_router.dart';
import 'package:meal_planner/data/config/routing/routes/product.routes.dart';
import 'package:meal_planner/data/config/routing/routes/recipe.routes.dart';
import 'package:meal_planner/ui/navigation/bottom.navigation.dart';
import 'package:meal_planner/ui/screens/product/add/screen.dart';
import 'package:meal_planner/ui/screens/product/all/screen.dart';
import 'package:meal_planner/ui/screens/product/id/screen.dart';
import 'package:meal_planner/ui/screens/recipe/add/screen.dart';
import 'package:meal_planner/ui/screens/recipe/id/screen.dart';
import 'package:meal_planner/ui/viewModels/product.viewModel.dart';
import 'package:meal_planner/ui/viewModels/recipe.viewModel.dart';
import 'package:provider/provider.dart';


final List<GoRoute> _productRoutes = [
  GoRoute(
    path: ProductRoutes.viewAll,
    builder: (context, state) => const ProductViewAllScreen(),
  ),

  GoRoute(
    path: ProductRoutes.add,
    builder: (context, state) => AddProductScreen(),
  ),

  GoRoute(
    path: "/products/:id",
    builder: (context, state) {
      final id = state.pathParameters["id"];
      context.read<ProductViewModel>().getById.execute(arg: id!);
      return ViewAndEditProductScreen();
    }
  )
];

final List<GoRoute> _recipeRoutes = [
  GoRoute(
    path: ProductRoutes.viewAll,
    builder: (context, state) => const ProductViewAllScreen(),
  ),
  GoRoute(
    path: RecipeRoutes.add,
    builder: (context, state) => AddRecipeScreen(),
  ),
  GoRoute(
    path: "/recipes/:id",
    builder: (context, state) {final id = state.pathParameters["id"];
      context.read<RecipeViewModel>().getById.execute(arg: id!);
      return RecipesViewScreen();
    } ,
  )
];



GoRouter router() => GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(
      path: "/home",
      builder: (context, state) => AppBottomNavigation()
    ),
    ..._productRoutes,
    ..._recipeRoutes,
  ]
);