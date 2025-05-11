import 'dart:io';
import 'package:flutter/material.dart';
import '../data/models/prediction_result.dart';
import '../data/services/prediction_service.dart';

class PredictionViewModel extends ChangeNotifier {
  final PredictionService _service = PredictionService();

  File? selectedImage;
  PredictionResult? result;
  String? errorMessage;
  bool isLoading = false;

  void setImage(File image) {
    selectedImage = image;
    result = null;
    errorMessage = null;
    notifyListeners();
  }

  Future<void> predict() async {
    if (selectedImage == null) {
      errorMessage = "No image selected.";
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      final response = await _service.predict(selectedImage!);
      if (response.containsKey("result")) {
        result = PredictionResult.fromJson(response);
        errorMessage = null;
      } else {
        errorMessage = response["error"] ?? "Unknown error";
      }
    } catch (e) {
      errorMessage = "Error: \${e.toString()}";
      print(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  void resetPrediction() {
    selectedImage = null;
    result = null;
    errorMessage = null;
    isLoading = false;
    notifyListeners();
  }

}