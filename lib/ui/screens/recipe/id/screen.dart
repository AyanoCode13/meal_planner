import 'package:flutter/material.dart';
import 'package:meal_planner/ui/shared/loading.dart';
import 'package:meal_planner/ui/viewModels/recipe.viewModel.dart';
import 'package:provider/provider.dart';

final class RecipesViewScreen extends StatelessWidget {
  const RecipesViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   
    return Material(
      child: LoadingState(
        commands: context.watch<RecipeViewModel>().commands, 
        notifiers: [context.watch<RecipeViewModel>()], 
        
        child: (context, _){
          final recipe = context.watch<RecipeViewModel>().recipe!;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(recipe.name),
              ),
              SliverList.builder(itemCount: recipe.ingredients.length ,itemBuilder: (context,index){
                final ingredient = recipe.ingredients.elementAt(index);
                return ListTile(title: Text(ingredient.name));
              })
            ],
          
          );
        }
      )
    );
  }
  
}