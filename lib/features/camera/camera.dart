import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../components/popup_camera_option.dart';
import '../../../../components/popup_category.dart';

class CameraFitur {
    static final List<String> _categories = ['Matematika', 'IPAS','PKN', 'Bahasa Indonesia', 'PJOK', 'Seni', 'Agama', 'Bahasa Inggris', 'Bahasa Daerah'];

  static Future<void> show(BuildContext context, Function(Map<String, dynamic>) onImagePicked) async {
    final category = await showCategoryPopup(context, _categories);
    if (category == null) return;

    final source = await showCameraOptionPopup(context);
    if (source == null) return;

    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: source == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );

    if (picked != null) {
      onImagePicked({'image': File(picked.path), 'category': category});
    }
  }
}