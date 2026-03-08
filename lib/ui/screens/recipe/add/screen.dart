import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_planner/domain/entities/product/product.entity.dart';

final class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final List<ProductEntity> _ingredients = [];
  final TextFormField _nameFormField = TextFormField(
    
    decoration: InputDecoration(
      
      labelText: "Name",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      
      
    ),
    controller: TextEditingController(),
  );

  final TextFormField _descriptionFormField = TextFormField(
    minLines: 4,
    maxLines: 10,
    decoration: InputDecoration(
      
      labelText: "Description",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      
    ),
    controller: TextEditingController(),
  );

  final _picker = ImagePicker();
  XFile? _image;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text.rich(TextSpan(text: "New Recipe")),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.save))
            ],
          ),
          SliverToBoxAdapter(
            child: ElevatedButton(
              onPressed: () {
                // your action here
              },
              style: ElevatedButton.styleFrom(
                
                fixedSize: MediaQuery.sizeOf(context) / 9,
                shape: CircleBorder()
              ),
              child: Icon(Icons.camera_alt, size: 32),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: MediaQuery.widthOf(context) * 0.7,
                child: _nameFormField
              ),
            ),
          )
        ],
      ),
    );
  }
}

/*
Scaffold(
      appBar: AppBar(
        title: const Text("New Recipe"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.save))],
      ),
      body: Center(
        child: SafeArea(
          child: Column(
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
                  children: [_nameFormField, _descriptionFormField],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
*/
