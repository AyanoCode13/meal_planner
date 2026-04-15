import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> selectImage(BuildContext context) async {
    final picker = ImagePicker();
    return showModalBottomSheet(
      useSafeArea: true,
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text("Take a photo"),
            onTap: () async {
              final selectedImage = await picker.pickImage(
                source: ImageSource.camera,
              );
               if(context.mounted) context.pop<XFile?>(selectedImage);
                
               
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text("Choose from gallery"),
            onTap: () async {
              final selectedImage = await picker.pickImage(
                source: ImageSource.gallery,
              );
               if(context.mounted) context.pop<XFile?>(selectedImage);
            },
          ),
        ],
      ),
    );
  }