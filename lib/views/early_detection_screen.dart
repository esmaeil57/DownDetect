import 'dart:io';

import 'package:down_detect/views/prediction_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../view_model/prediction_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';

class PredictionScreen extends StatelessWidget {
  const PredictionScreen({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Provider.of<PredictionViewModel>(
        context,
        listen: false,
      ).setImage(File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PredictionViewModel>(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 4,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // or Icons.arrow_back_ios
          onPressed: () {
            Navigator.pop(context); // 👈 This goes back to the previous screen
          },
        ),
        flexibleSpace: Container(
          height: MediaQuery.of(context).size.height*0.13,
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
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical:20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(width: 8),
              Text(
                "Early Detection",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(mediaQuery.size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Upload a photo of the ultrasound picture and you'll get the risk"
                  " percentage of the baby having Down Syndrome",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(fontSize: mediaQuery.size.width * 0.04),
            ),
            SizedBox(height: mediaQuery.size.height * 0.03),
            GestureDetector(
              onTap:()=> _pickImage(context),
              child:Container(
                width: mediaQuery.size.width * 0.6,
                height: mediaQuery.size.width * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                viewModel.selectedImage == null
                    ? Center(
                  child: Icon(
                    Icons.add,
                    size: mediaQuery.size.width * 0.1,
                  ),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    viewModel.selectedImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              ) ,
            ),
            SizedBox(height: mediaQuery.size.height * 0.02),
            TextButton.icon(
              onPressed: () => _pickImage(context),
              icon: Icon(Icons.upload_file, size: mediaQuery.size.width * 0.05 ,
                color: Color(0xFF0E6C73),),
              label: Text(
                "Upload photo from library",
                style: GoogleFonts.lato(fontSize: mediaQuery.size.width * 0.04,
                    color: Color(0xFF0E6C73)),
              ),
            ),
            SizedBox(height: mediaQuery.size.height * 0.03),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(
                    vertical: mediaQuery.size.height * 0.02,
                  ),
                ),
                onPressed:
                    viewModel.isLoading
                        ? null
                        : () async {
                          await viewModel.predict();
                          if (viewModel.result != null ||
                              viewModel.errorMessage != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PredictionResultScreen(),
                              ),
                            ).then((_) {
                              viewModel.resetPrediction();
                            });
                          }
                        },
                child: Text(
                  "Predict",
                  style: GoogleFonts.lato(
                    fontSize: mediaQuery.size.width * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(height: mediaQuery.size.height * 0.02),
            if (viewModel.isLoading)
              SizedBox(
                height: mediaQuery.size.width * 0.1,
                width: mediaQuery.size.width * 0.1,
                child: const CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
