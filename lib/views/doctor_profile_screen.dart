/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/therapist_model.dart';
import '../view_model/doctor_profile_viewmodel.dart';

class DoctorProfilePage extends StatelessWidget {
  final Therapist therapist;

  const DoctorProfilePage({super.key, required this.therapist});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DoctorProfileViewModel(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image Section
                Container(
                  color: Colors.white,
                  child: ClipRRect(
                    child: Image.asset(
                      therapist.profileImage,
                      fit: BoxFit.cover,
                      height: 400,
                      width: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Info Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        therapist.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            therapist.phonenumber,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              // Add call logic here later
                            },
                            child: Image.asset("images/9946341 1.png"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: List.generate(therapist.rate, (index) {
                          return const Icon(Icons.star,
                              color: Colors.amber, size: 24);
                        }),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        therapist.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const AppointmentForm(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: const Color(0xFF00796B),
                          ),
                          child: const Text(
                            'Appointment',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentForm extends StatelessWidget {
  const AppointmentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DoctorProfileViewModel>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Form(
          key: viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '        Appointment',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00796B),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Name",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              TextFormField(
                controller: viewModel.nameController,
                decoration: _fieldDecoration('Enter your name'),
                validator: (value) =>
                value!.isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 20),
              const Text(
                "Email",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              TextFormField(
                controller: viewModel.emailController,
                decoration: _fieldDecoration('Enter your email'),
                validator: (value) =>
                value!.isEmpty ? 'Email is required' : null,
              ),
              const SizedBox(height: 20),
              const Text(
                "Phone number",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              TextFormField(
                controller: viewModel.phoneController,
                decoration: _fieldDecoration('(+20) Number'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                value!.isEmpty ? 'Phone number is required' : null,
              ),
              const SizedBox(height: 20),
              const Text(
                "Gender",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              DropdownButtonFormField<String>(
                value: viewModel.selectedGender,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                hint: const Text(
                  "Enter your gender",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
                ),
                items: ['Male', 'Female']
                    .map((gender) => DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                ))
                    .toList(),
                onChanged: viewModel.setGender,
                validator: (value) =>
                value == null ? 'Please select a gender' : null,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  final success = viewModel.submitAppointment(context);
                  if (success) Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF00796B),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 18,),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      contentPadding:
      const EdgeInsets.symmetric(vertical: 0, horizontal: 17),
      filled: true,
      fillColor: Colors.grey[200],
      hintText: hint,
      hintStyle:
      const TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
*/
