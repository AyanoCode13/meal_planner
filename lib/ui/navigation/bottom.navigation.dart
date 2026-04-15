import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/routing/routes/product.routes.dart';
import '../../config/routing/routes/recipe.routes.dart';

final class AppBottomNavigation extends StatefulWidget {
  final Widget? _child;

  const AppBottomNavigation({super.key, required Widget child})
    : _child = child;

  @override
  State<AppBottomNavigation> createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  final List<String> _pages = [ProductRoutes.all, RecipeRoutes.all];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final selectedIndex = _pages.indexWhere((t) => location.startsWith(t));
    // TODO: implement build
    return Scaffold(
      body: widget._child, // ← This is where the active route renders
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex < 0 ? 0 : selectedIndex,
        onDestinationSelected: (index) {
          context.go(_pages[index]);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Products'),
          NavigationDestination(icon: Icon(Icons.food_bank), label: 'Recipes'),
        ],
      ),
    );
  }
}
