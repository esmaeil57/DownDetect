import 'package:flutter/material.dart';

class DoctorProfileViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? selectedGender;

  void setGender(String? gender) {
    selectedGender = gender;
    notifyListeners();
  }

  bool submitAppointment(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment submitted successfully')),
      );
      clearForm();
      return true;
    }
    return false;
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    selectedGender = null;
    notifyListeners();
  }
}
