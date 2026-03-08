import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/config/routing/routes/product.routes.dart';
import 'package:meal_planner/ui/loading.dart';
import 'package:meal_planner/ui/screens/product/all/products.list.dart';
import 'package:meal_planner/ui/viewModels/product.viewModel.dart';
import 'package:provider/provider.dart';

final class ProductViewAllScreen extends StatelessWidget {
  const ProductViewAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LoadingState(
        commands: [context.watch<ProductViewModel>().load],
        notifiers: [context.watch<ProductViewModel>()],
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Products'),
              actions: [
                IconButton.filled(
                  onPressed: () {
                    context.push(ProductRoutes.add);
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchBar(
                  hintText: 'Search',
                  trailing: [Icon(Icons.search)],
                ),
              ),
            ),

            ProductsList(),
          ],
        ),
      ),
    );
  }
}


