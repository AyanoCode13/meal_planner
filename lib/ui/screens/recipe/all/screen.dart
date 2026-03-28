import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/config/routing/routes/recipe.routes.dart';
import 'package:meal_planner/ui/screens/recipe/all/recipe.list.dart';
import 'package:meal_planner/ui/viewModels/recipe.viewModel.dart';
import 'package:provider/provider.dart';

final class RecipesViewAllScreen extends StatelessWidget {
  const RecipesViewAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListenableBuilder(
        listenable: context.watch<RecipeViewModel>().load,
        builder: (context, child) {
          if (context.watch<RecipeViewModel>().load.running) {
            return const Center(child: CircularProgressIndicator());
          }
          if (context.watch<RecipeViewModel>().load.failed) {
            return const Center(child: Text('Error loading products'));
          }
          return child!;
        },
        child: ListenableBuilder(
          listenable: context.watch<RecipeViewModel>(),
          builder: (context, _) {
            return SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text('Recipes'),
                    actions: [
                      IconButton.filled(
                        onPressed: () {
                          context.push(RecipeRoutes.add);
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  RecipeList(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
