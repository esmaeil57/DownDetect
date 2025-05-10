import 'dart:io';

import 'package:down_detect/views/prediction_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../view_model/prediction_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';

/*class EarlyDetectionScreen extends StatelessWidget {
  const EarlyDetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EarlyDetectionViewModel>(context);

    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        automaticallyImplyLeading: false,
        elevation: 4,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
        colors: [Color(0xFF0E6C73), Color(0xFF199CA4)],
           begin: Alignment.topLeft,
           end: Alignment.bottomRight,
          ),
        borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
          ),
          )),
        centerTitle: true,
        title: Text(
          "Early Detection",
          style: GoogleFonts.lato(textStyle: TextStyle(color: Colors.black)),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0),
              child: const Text(
                "Upload a photo of the ultrasound picture and you'll get the risk"
                    " percentage of the baby having down syndrome .",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),

              ),
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
                    borderRadius: BorderRadius.circular(10),
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
}*/

class PredictionScreen extends StatelessWidget {
  const PredictionScreen({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Provider.of<PredictionViewModel>(context, listen: false)
          .setImage(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PredictionViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Early detection"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Upload a photo of the ultrasound picture and you'll get the risk percentage of the baby having down syndrome",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: viewModel.selectedImage == null
                  ? const Center(child: Icon(Icons.add, size: 40))
                  : ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child:
                Image.file(viewModel.selectedImage!, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: () => _pickImage(context),
              icon: const Icon(Icons.upload_file),
              label: const Text("Upload photo from library"),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: viewModel.isLoading
                    ? null
                    : () async {
                  await viewModel.predict();
                  if (viewModel.result != null || viewModel.errorMessage != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PredictionResultScreen(),
                      ),
                    );
                  }
                },
                child: const Text("Predict"),
              ),
            ),
            const SizedBox(height: 20),
            if (viewModel.isLoading) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
