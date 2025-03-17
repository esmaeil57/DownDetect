import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EarlyDetectionScreen extends StatefulWidget {
  const EarlyDetectionScreen({super.key});

  @override
  _EarlyDetectionScreenState createState() => _EarlyDetectionScreenState();
}

class _EarlyDetectionScreenState extends State<EarlyDetectionScreen> {
  File? _selectedImage;

  Future<void> _uploadImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1BCCD9),
        title: const Text(
          "        Early detection",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical:60,horizontal:10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Upload a photo of the ultrasound picture and you'll get the risk percentage of the baby having down syndrome",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 70),
            TextButton(
              onPressed: () {
              },
              child: const Text(
                "Scan the picture",
                textAlign: TextAlign.start,
                style: TextStyle(

                  color: Colors.black,
                  fontSize: 16,


                ),
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.center,
                child:
            GestureDetector(
              onTap: _uploadImage,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: _selectedImage == null
                    ? const Center(
                  child: Icon(Icons.add_circle_outline, size: 40, color: Colors.black),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(_selectedImage!, fit: BoxFit.cover),
                ),
              ),
            )
            ),
            const SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child:
            TextButton.icon(
              onPressed: _uploadImage,
              icon: Image.asset("images/Upload-Icon-Logo-PNG-Photos 1.png"),
              label: const Text(
                "Upload photo from library",
                style: TextStyle(
                  color: Colors.black,
                    decoration: TextDecoration.underline,
                    fontSize: 14),
              ),
            )),
          ],
        ),
      ),
    );
  }
}