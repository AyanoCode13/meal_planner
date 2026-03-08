import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_planner/domain/dto/product/create.product.dto.dart';
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
      border: OutlineInputBorder(),
    ),
    controller: TextEditingController(),
  );

  final TextFormField _priceFormField = TextFormField(
    decoration: InputDecoration(
      labelText: "Price",
      border: OutlineInputBorder(),
    ),
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    controller: TextEditingController(),
  );

  final TextFormField _quantityFormField = TextFormField(
    decoration: InputDecoration(
      labelText: "Quantity",
      border: OutlineInputBorder(),
    ),
    keyboardType: TextInputType.number,
    controller: TextEditingController(),
  );

  final _picker = ImagePicker();

  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ProductViewModel>().add.execute(
                arg: CreateProductDTO(
                  name: _nameFormField.controller!.text,
                  description: "",
                  price: _priceFormField.controller!.text,
                  quantity: _quantityFormField.controller!.text,
                  image: _image,
                ),
              );
              context.pop();
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: GestureDetector(
                onTap: () async {
                  //Show a toast with 2 options: "Take a photo" and "Choose from gallery"
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.camera_alt),
                          title: Text("Take a photo"),
                          onTap: () async {
                            final pickedFile = await _picker.pickImage(
                              source: ImageSource.camera,
                            );
                            if (pickedFile != null) {
                              setState(() {
                                _image = pickedFile;
                                context.pop();
                              });
                            }
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.photo_library),
                          title: Text("Choose from gallery"),
                          onTap: () async {
                            final pickedFile = await _picker.pickImage(
                              source: ImageSource.gallery,
                            );
                            if (pickedFile != null) {
                              setState(() {
                                _image = pickedFile;
                                context.pop();
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  constraints: BoxConstraints.tight(
                    MediaQuery.sizeOf(context) * 0.9,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: _image != null ? BoxFit.cover : null,
                      scale: _image != null ? 0.2 : 1.0,
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                spacing: 10,
                children: [_nameFormField, _priceFormField, _quantityFormField],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
