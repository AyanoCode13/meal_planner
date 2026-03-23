import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/config/routing/routes/product.routes.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';

import 'package:meal_planner/ui/viewModels/product.viewModel.dart';
import 'package:provider/provider.dart';



final class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductViewModel>().products;
    return SliverList.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: _ProductListItem(product: products.elementAt(index)),
      ),
    );
  }
}

final class _ProductListItem extends StatelessWidget {
  final ProductEntity product;
  const _ProductListItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push(ProductRoutes.view(product));
      },
      leading: Text.rich(TextSpan(text: "${product.quantity}x")),
      title: Text.rich(TextSpan(text: "Name: ${product.name}")),
      subtitle: Text.rich(TextSpan(text: "Price: ${product.price}")),
      trailing: IconButton(onPressed: (){
        context.read<ProductViewModel>().delete.execute(arg: product);
      }, icon: Icon(Icons.delete)),
    );
  }
}