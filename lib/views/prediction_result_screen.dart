import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/prediction_viewmodel.dart';

class PredictionResultScreen extends StatelessWidget {
  const PredictionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PredictionViewModel>(context, listen: false);
    final result = viewModel.result;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Prediction Result"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: result != null
            ? Column(
          children: [
            const Text(
              "Result in Ultrasound Image",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Image.file(viewModel.selectedImage!, height: 200),
            const SizedBox(height: 20),
            Text(
              "result: '${result.result}'",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "confidence: '${result.confidence.toStringAsFixed(2)}%'",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "predicted_class_index: ${result.predictedClassIndex}",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        )
            : Center(
          child: Text(
            viewModel.errorMessage ?? 'No result available.',
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
