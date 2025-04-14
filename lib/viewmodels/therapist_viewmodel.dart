import 'package:flutter/material.dart';
import '../models/therapist.dart';

class TherapistViewModel extends ChangeNotifier {
  final List<Therapist> _therapists = [
    Therapist(
      name: 'Dr Sima Alpha',
      phone: '(+20) 1056422890',
      rating: 5,
      profileImage: 'images/Ellipse 6.png',
      description:
      'Dr Sima Alpha is a psychologist specializing in Down syndrome. Over 6 years of experience helping kids build emotional resilience and confidence.',
    ),
    Therapist(
      name: 'Dr Samy Ahmed',
      phone: '(+20) 1056422891',
      rating: 4,
      profileImage: 'images/Ellipse 7.png',
      description: 'Dr Samy helps families and children understand and adapt to Down syndrome. Known for kind-hearted, practical care.',
    ),
    Therapist(
      name: 'Dr Emilly',
      phone: '(+20) 1056422892',
      rating: 5,
      profileImage: 'images/Ellipse 8.png',
      description: 'Dr Emilly focuses on early development and communication therapy for children with Down syndrome.',
    ),
    Therapist(
      name: 'Dr Ama',
      phone: '(+20) 1056422893',
      rating: 3,
      profileImage: 'images/Ellipse 9.png',
      description: 'Dr Ama supports parents with behavioral guidance and therapy options tailored to family needs.',
    ),
    Therapist(
      name: 'Dr Amira',
      phone: '(+20) 1056422894',
      rating: 3,
      profileImage: 'images/Ellipse 10.png',
      description: 'Dr Amira leads therapy sessions that promote physical and emotional wellness for children with Down syndrome.',
    ),
  ];

  List<Therapist> get therapists => _therapists;
}
