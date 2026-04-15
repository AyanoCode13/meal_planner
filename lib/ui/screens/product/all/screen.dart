import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/config/routing/routes/product.routes.dart';
import 'package:meal_planner/domain/domain.dart';
import 'package:meal_planner/ui/shared/loading.dart';
import 'package:provider/provider.dart';

import '../../../viewModels/view.models.dart';

final class ProductViewAllScreen extends StatelessWidget {
  const ProductViewAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productViewModel = context.read<ProductViewModel>();
    return LoadingState(
      commands: productViewModel.commands,
      notifiers: [productViewModel],
      child: (context, _) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Products'),
              actions: [
                IconButton.filled(
                  onPressed: () async {
                    final res = await context.push<ProductEntity>(
                      ProductRoutes.add,
                    );

                    if (res != null) {
                      productViewModel.add.execute(arg: res);
                    }
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
            SliverList.builder(
              itemCount: productViewModel.data.length,
              itemBuilder: (context, index){
                final item = productViewModel.data.elementAt(index);
                return ListTile(
                  title: Text(item.name),
                  trailing: IconButton.filled(
                    onPressed: () async {
                      await productViewModel.delete.execute(arg: item);
                    }, 
                    icon: Icon(Icons.delete)
                  ),
                );
              }
            )
          ],
        );
      },
    );
  }
}
