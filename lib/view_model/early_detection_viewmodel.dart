import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EarlyDetectionViewModel extends ChangeNotifier {
  File? _selectedImage;
  bool _isLoading = false;

  File? get selectedImage => _selectedImage;
  bool get isLoading => _isLoading;

  Future<void> uploadImage() async {
    try {
      final pickedFile =
      await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Image upload failed: $e");
    }
  }

  void clearImage() {
    _selectedImage = null;
    notifyListeners();
  }
}
