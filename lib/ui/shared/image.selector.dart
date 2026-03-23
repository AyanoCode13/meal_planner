import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> showOptions({required BuildContext context, required Function(XFile image) setSelectedImage}) async {
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
              final pickedFile = await picker.pickImage(
                source: ImageSource.camera,
              );
              if (pickedFile != null) {
               setSelectedImage(pickedFile);
               if(context.mounted){
                context.pop();
               }
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text("Choose from gallery"),
            onTap: () async {
              final pickedFile = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (pickedFile != null) {
                setSelectedImage(pickedFile);
                if(context.mounted){
                  context.pop();
                }
              }
            },
          ),
        ],
      ),
    );
  }