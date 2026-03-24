import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_planner/domain/dto/product/create.product.dto.dart';
import 'package:meal_planner/ui/shared/image.selector.dart';
import 'package:meal_planner/ui/viewModels/product.viewModel.dart';
import 'package:provider/provider.dart';

final class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextFormField _nameFormField = TextFormField(
    decoration: InputDecoration(
      labelText: "Name",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    ),
    controller: TextEditingController(),
  );

  final TextFormField _priceFormField = TextFormField(
    decoration: InputDecoration(
      labelText: "Price",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    ),
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    controller: TextEditingController(),
  );

  final TextFormField _quantityFormField = TextFormField(
    decoration: InputDecoration(
      labelText: "Quantity",
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    ),
    keyboardType: TextInputType.number,
    controller: TextEditingController(),
  );

  final _picker = ImagePicker();
  XFile? _image;

  // Future<void> showOptions(BuildContext context) {
  //   final _picker = ImagePicker();
  //   return showModalBottomSheet(
  //     context: context,
  //     builder: (context) => Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         ListTile(
  //           leading: Icon(Icons.camera_alt),
  //           title: Text("Take a photo"),
  //           onTap: () async {
  //             final pickedFile = await _picker.pickImage(
  //               source: ImageSource.camera,
  //             );
  //             if (pickedFile != null) {
  //               setState(() {
  //                 _image = pickedFile;
  //                 context.pop();
  //               });
  //             }
  //           },
  //         ),
  //         ListTile(
  //           leading: Icon(Icons.photo_library),
  //           title: Text("Choose from gallery"),
  //           onTap: () async {
  //             final pickedFile = await _picker.pickImage(
  //               source: ImageSource.gallery,
  //             );
  //             if (pickedFile != null) {
  //               setState(() {
  //                 _image = pickedFile;
  //                 context.pop();
  //               });
  //             }
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
     child: Center(
      child: Text("Work In Progress"),
     ),
    );
  }
}
/*
 child: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              title: Text("New Product"),
              actions: [
                IconButton.filled(
                  onPressed: () {
                    context.read<ProductViewModel>().add.execute(
                      arg: CreateProductDTO(
                        name: _nameFormField.controller?.text ?? "",
                        price: _priceFormField.controller?.text ?? "0.0",
                        quantity: _quantityFormField.controller?.text ?? "1",
                        description: "",
                        image: _image
                      ),
                    );
                    context.pop();
                  },
                  icon: Icon(Icons.save_rounded),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () async {
                  //Show a toast with 2 options: "Take a photo" and "Choose from gallery"
                  showOptions(context: context, setSelectedImage: (image) {
                    setState(() {
                      _image = image;
                    });
                  },);
                },
                child: Container(
                  constraints: BoxConstraints.tight(
                    MediaQuery.sizeOf(context) * 0.6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      scale: 0.3,
                      fit: BoxFit.scaleDown,
                      image: _image != null
                          ? FileImage(File(_image!.path))
                          : AssetImage("assets/no_image.png"),
                    ),
                  ),
                  child: Center(
                    child: _image != null
                        ? IconButton(
                            splashColor: Colors.white,
                            splashRadius: 48,
                            iconSize: 48,
                            onPressed: () {
                              setState(() {
                                _image = null;
                              });
                            },
                            icon: Icon(Icons.delete, color: Colors.red),
                          )
                        : null,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _nameFormField,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _priceFormField,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _quantityFormField,
              ),
            ),
          ],
        ),
      ),*/