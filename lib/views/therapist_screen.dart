import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/therapist_viewmodel.dart';
import '../views/doctor_profile_screen.dart';
import '../models/therapist.dart';

class TherapistListScreen extends StatelessWidget {
  const TherapistListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final therapistList = Provider.of<TherapistViewModel>(context).therapists;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1BCCD9),
        title: const Text("Find a Therapist"),
      ),
      body: ListView.builder(
        itemCount: therapistList.length,
        itemBuilder: (context, index) {
          final therapist = therapistList[index];
          return TherapistCard(therapist: therapist);
        },
      ),
    );
  }
}

class TherapistCard extends StatelessWidget {
  final Therapist therapist;

  const TherapistCard({super.key, required this.therapist});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DoctorProfilePage(therapist: therapist),
        ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(therapist.profileImage),
              radius: 30,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    therapist.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(therapist.phone),
                  Row(
                    children: List.generate(
                      therapist.rating,
                          (index) => const Icon(Icons.star,
                          color: Colors.yellow, size: 16),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
