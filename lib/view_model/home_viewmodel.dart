import 'package:flutter/material.dart';
import '../views/early_detection_screen.dart';
import '../views/therapist_screen.dart';

class HomeOption {
  final String image;
  final String title;
  final String description;
  final Widget? targetScreen;

  HomeOption({
    required this.image,
    required this.title,
    required this.description,
    this.targetScreen,
  });
}

class HomeViewModel extends ChangeNotifier {
  final List<HomeOption> homeOptions = [
    HomeOption(
      image: "images/camera-icon-1024x832-h0gkd0hw 1.png",
      title: "Early detection",
      description:
      "Upload a photo of the ultrasound picture to know the risk percentage of your baby having Down syndrome.",
      targetScreen: const EarlyDetectionScreen(),
    ),
    /*HomeOption(
      image: "images/3890590-200 1 (1).png",
      title: "Find a therapist",
      description:
      "You can easily find trusted therapists specializing in Down syndrome. We provide a list of recommended professionals with detailed profiles, ratings, and contact information",
      targetScreen: const TherapistListScreen(),
    ),*/
    HomeOption(
      image: "images/3047859 1.png",
      title: "Supportive Community",
      description:
      "Connect with other parents and families who share similar experiences. Our app provides a safe space to exchange advice, share stories, and offer support",
    ),
    HomeOption(
      image: "images/videooooo 1.png",
      title: "Helpful Video Library",
      description:
      "Explore a collection of videos featuring real-life stories from other parents and individuals with Down syndrome, sharing their experiences and insights, and other educational videos",
    ),
  ];
}
