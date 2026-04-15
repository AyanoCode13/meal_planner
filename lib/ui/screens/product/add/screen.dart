import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_planner/domain/domain.dart';
import 'package:meal_planner/domain/dto/product/create.product.dto.dart';
import 'package:meal_planner/ui/shared/image.selector.dart';

final class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameEditingController = TextEditingController();
  final _priceEditingController = TextEditingController();
  final _quantityEditingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose

    _nameEditingController.dispose();
    _priceEditingController.dispose();
    _quantityEditingController.dispose();
    super.dispose();
  }

  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                IconButton.filled(
                  onPressed: () {
                    
                    final dto = CreateProductDTO(
                      name: _nameEditingController.text,
                      price: _priceEditingController.text,
                      quantity: _quantityEditingController.text,
                      files: _image != null ? [_image!] : [],
                    );
                    
                    final product = ProductEntity.create(dto: dto);
                    print(product);
                    if (context.mounted) context.pop<ProductEntity>(product);
                  },
                  icon: Icon(Icons.save),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () async {
                  final res = await selectImage(context);
                  setState(() {
                    _image = res;
                  });
                },
                child: Container(
                  width: MediaQuery.widthOf(context) / 7,
                  height: MediaQuery.heightOf(context) / 7,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _image != null
                          ? FileImage(File(_image!.path))
                          : AssetImage("assets/no_image.png"),
                    ),
                  ),
                  child: Center(
                    child: _image != null
                        ? IconButton.filled(
                            onPressed: () {
                              setState(() {
                                _image = null;
                              });
                            },
                            icon: Icon(Icons.delete),
                          )
                        : null,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  
                  spacing: 5.0,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: _nameEditingController,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Price",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: _priceEditingController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Quantity",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: _quantityEditingController,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
