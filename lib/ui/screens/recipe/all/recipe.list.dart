import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/config/routing/routes/recipe.routes.dart';
import 'package:meal_planner/domain/entities/recipe/recipe.entity.dart';
import 'package:meal_planner/ui/viewModels/recipe.viewModel.dart';
import 'package:provider/provider.dart';

final class RecipeList extends StatelessWidget {
  const RecipeList({super.key});

  @override
  Widget build(BuildContext context) {
    final recipes = context.watch<RecipeViewModel>().data;
    return SliverList.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: _RecipeListItem(recipe: recipes.elementAt(index)),
      ),
    );
  }
}

final class _RecipeListItem extends StatelessWidget {
  final RecipeEntity _recipe;

  const _RecipeListItem({super.key, required RecipeEntity recipe})
    : _recipe = recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(RecipeRoutes.view(_recipe));
      },
      child: Container(
        constraints: BoxConstraints.tight(MediaQuery.sizeOf(context) * 0.3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.4),
              BlendMode.darken,
            ),
            image: _recipe.images[0] != null
                ? FileImage(_recipe.images[0]!)
                : AssetImage("assets/no_image.png"),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text(
                  _recipe.name,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
            Row(children: [Text(_recipe.price.toString())]),
          ],
        ),
      ),
    );
  }
}
