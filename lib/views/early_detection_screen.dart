import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/early_detection_viewmodel.dart';

class EarlyDetectionScreen extends StatelessWidget {
  const EarlyDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EarlyDetectionViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1BCCD9),
        title: const Text(
          "        Early detection",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const Text(
              "Upload a photo of the ultrasound picture and you'll get the risk percentage of the baby having down syndrome",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            TextButton(
              onPressed: () {
                // Placeholder for scan logic
              },
              child: const Text(
                "Scan the picture",
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: viewModel.uploadImage,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: viewModel.selectedImage == null
                      ? const Center(
                    child: Icon(
                      Icons.add_circle_outline,
                      size: 40,
                      color: Colors.black,
                    ),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      viewModel.selectedImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Align(
              alignment: Alignment.center,
              child: TextButton.icon(
                onPressed: viewModel.uploadImage,
                icon:
                Image.asset("images/Upload-Icon-Logo-PNG-Photos 1.png"),
                label: const Text(
                  "Upload photo from library",
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
