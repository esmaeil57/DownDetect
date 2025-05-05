import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/early_detection_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';

class EarlyDetectionScreen extends StatelessWidget {
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
}
