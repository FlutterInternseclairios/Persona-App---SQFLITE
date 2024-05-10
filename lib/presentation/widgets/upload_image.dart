import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImageFromGalleryOrCamera(BuildContext context) async {
  final picker = ImagePicker();
  final imageSource = await showDialog<ImageSource>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Select Image'),
      content: Text('Choose from gallery or camera'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, ImageSource.gallery),
          child: Text('Gallery'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, ImageSource.camera),
          child: Text('Camera'),
        ),
      ],
    ),
  );

  if (imageSource == null) {
    // User canceled, return null.
    return null;
  }

  try {
    final pickedFile = await picker.pickImage(source: imageSource);
    return pickedFile;
  } catch (e) {
    // Handle errors
    print('Error picking image: $e');
    return null;
  }
}
