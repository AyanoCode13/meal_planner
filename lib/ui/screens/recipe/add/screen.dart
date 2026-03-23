import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_planner/config/routing/routes/product.routes.dart';
import 'package:meal_planner/domain/dto/product/create.product.dto.dart';
import 'package:meal_planner/domain/dto/recipe/create.recipe.dto.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';
import 'package:meal_planner/ui/shared/image.selector.dart';
import 'package:meal_planner/ui/viewModels/product.viewModel.dart';
import 'package:meal_planner/ui/viewModels/recipe.viewModel.dart';
import 'package:provider/provider.dart';

final class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextFormField _nameFormField = TextFormField(
    decoration: InputDecoration(
      labelText: "Name",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    ),
    controller: TextEditingController(),
  );

  final TextFormField _descriptionFormField = TextFormField(
    minLines: 4,
    maxLines: 10,
    decoration: InputDecoration(
      labelText: "Description",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    ),
    controller: TextEditingController(),
  );
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  final List<ProductEntity> _ingredients = [];
  XFile? _image;
  late ProductEntity? _selectedProduct;
  late int? _selectedQuantity;
  double _total = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedProduct = null;
    _selectedQuantity = null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _productController.dispose();
    _quantityController.dispose();
    _nameFormField.controller!.dispose();
    _descriptionFormField.controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductViewModel>().products;
    return Material(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text.rich(TextSpan(text: "New Recipe")),
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<RecipeViewModel>().add.execute(
                      arg: CreateRecipeDTO(
                        name: _nameFormField.controller!.text,
                        ingredients: _ingredients.toSet().toList(),
                        image: _image,
                      ),
                    );
                    context.pop();
                  },
                  icon: Icon(Icons.save),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                onPressed: () {
                  showOptions(
                    context: context,
                    setSelectedImage: (image) {
                      setState(() {
                        _image = image;
                      });
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: MediaQuery.sizeOf(context) / 9,
                  shape: CircleBorder(),
                ),
                child: Icon(Icons.camera_alt, size: 32),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: MediaQuery.widthOf(context) * 0.7,
                  child: _nameFormField,
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: MediaQuery.widthOf(context) * 0.7,
                  child: _descriptionFormField,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: products.isEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Empty storage"),
                        ElevatedButton.icon(
                          label: Text.rich(TextSpan(text: "Add Products")),
                          onPressed: () {
                            context.push(ProductRoutes.add);
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: DropdownMenu(
                            initialSelection: _selectedProduct,
                            controller: _productController,

                            helperText: "Ingredient",

                            enableFilter: true,
                            enableSearch: true,
                            menuStyle: MenuStyle(
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),

                            dropdownMenuEntries: products
                                .map(
                                  (p) => DropdownMenuEntry<ProductEntity>(
                                    value: p,
                                    label: p.name,
                                  ),
                                )
                                .toList(),
                            onSelected: (value) {
                              if (value != null) {
                                setState(() {
                                  _selectedProduct = value;
                                });
                              }
                            },
                          ),
                        ),
                        Flexible(
                          child: DropdownMenu(
                            controller: _quantityController,
                            initialSelection: _selectedQuantity,
                            helperText: "Quantity",
                            enableFilter: true,
                            enableSearch: true,
                            menuStyle: MenuStyle(
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),

                            dropdownMenuEntries:
                                List.generate(9, (int index) => index + 1)
                                    .map(
                                      (i) => DropdownMenuEntry<int>(
                                        value: i,
                                        label: i.toString(),
                                      ),
                                    )
                                    .toList(),

                            onSelected: (value) {
                              setState(() {
                                _selectedQuantity = value ?? 0;
                              });
                            },
                          ),
                        ),
                        Flexible(
                          child: IconButton.filled(
                            onPressed: () {
                              if (_selectedProduct != null) {
                                final duplicateId = _ingredients.indexWhere(
                                  (e) => e.name == _selectedProduct!.name,
                                );

                                if (duplicateId != -1) {
                                  setState(() {
                                    _ingredients[duplicateId] =
                                        _ingredients[duplicateId].copyWith(
                                          quantity: _selectedQuantity ?? 0,
                                        );
                                  });
                                } else {
                                  setState(() {
                                    _ingredients.add(
                                      _selectedProduct!.copyWith(
                                        quantity: _selectedQuantity ?? 0,
                                      ),
                                    );
                                  });
                                }
                                setState(() {
                                  _total = _ingredients.fold(0.0, (value, e) {
                                    return value + e.price * e.quantity;
                                  });
                                });

                                _productController.clear();
                                _quantityController.clear();
                                return;
                              }
                            },
                            icon: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text("Total: "), Text(_total.toStringAsFixed(2))],
              ),
            ),
            SliverList.builder(
              itemCount: _ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = _ingredients.elementAt(index);
                return ListTile(
                  leading: ingredient.image != null
                      ? Image.file(ingredient.image!)
                      : Image.asset("assets/no_image.png"),
                  subtitle: Text("${ingredient.quantity}x ${ingredient.price}"),
                  title: Text(ingredient.name),
                  trailing: IconButton.filled(
                    onPressed: () {
                      setState(() {
                        _ingredients.removeAt(index);
                      });
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
