import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../view_model/therapist_viewmodel.dart';
import '../data/models/therapist_model.dart';

class AddTherapistScreen extends StatefulWidget {
  const AddTherapistScreen({super.key});

  @override
  State<AddTherapistScreen> createState() => _AddTherapistScreenState();
}

class _AddTherapistScreenState extends State<AddTherapistScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _availableSlotsController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  String? _selectedGender;

  @override
  void dispose() {
    _nameController.dispose();
    _rateController.dispose();
    _phoneController.dispose();
    _availableSlotsController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Custom AppBar
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0E6C73), Color(0xFF199CA4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Center(
                      child: Text(
                        "Add a Therapist",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF00838F),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Name Field
                    _buildFormField(
                      label: 'Name',
                      controller: _nameController,
                      hint: 'Enter your name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Rate Field
                    _buildFormField(
                      label: 'Rate',
                      controller: _rateController,
                      hint: 'Add a rate number',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a rate';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Phone Field
                    _buildFormField(
                      label: 'phone number',
                      controller: _phoneController,
                      hint: '(+20) Number',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Gender Dropdown
                    _buildGenderDropdown(),
                    const SizedBox(height: 20),

                    // Available Slots Field
                    _buildFormField(
                      label: 'Availableslots',
                      controller: _availableSlotsController,
                      hint: 'Enter availableslots',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter available slots';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Location Field
                    _buildFormField(
                      label: 'Location',
                      controller: _locationController,
                      hint: 'Enter your location',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a location';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00838F),
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        onPressed: _submitForm,
                        child: Text(
                          'Save',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF00838F),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[400],
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Color(0xFF00838F), width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF00838F),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: 'Enter your Gender',
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[400],
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Color(0xFF00838F), width: 2),
              ),
            ),
            value: _selectedGender,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a gender';
              }
              return null;
            },
            items: ['Male', 'Female'].map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(
                  gender,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedGender = newValue;
              });
            },
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF00838F),
            ),
          ),
        ),
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Adding therapist..."),
              ],
            ),
          );
        },
      );

      try {
        final therapist = Therapist(
          id: '', // ID will be assigned by the server
          name: _nameController.text.trim(),
          phonenumber: _phoneController.text.trim(),
          rate: _rateController.text.trim(),
          location: _locationController.text.trim(),
          availableSlots: _availableSlotsController.text.trim(),
          gender: _selectedGender ?? '',
        );

        print('Form data: ${therapist.toJson()}'); // Debug log

        // Get the ViewModel
        final therapistViewModel = Provider.of<TherapistViewModel>(context, listen: false);

        // Add therapist
        await therapistViewModel.addTherapist(therapist);

        // Hide loading indicator
        if (mounted) Navigator.of(context).pop();

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Therapist added successfully!'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );

          // Navigate back to previous screen
          Navigator.of(context).pop(true); // Pass true to indicate success
        }

      } catch (error) {
        print('Submit form error: $error'); // Debug log
        // Hide loading indicator
        if (mounted) Navigator.of(context).pop();
      }
    }
  }
}