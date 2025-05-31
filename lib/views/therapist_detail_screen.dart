import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/models/therapist_model.dart';
import '../view_model/doctor_profile_viewmodel.dart';

class TherapistDetailScreen extends StatefulWidget {
  final Therapist therapist;
  const TherapistDetailScreen({
    super.key,
    required this.therapist,
  });

  @override
  State<TherapistDetailScreen> createState() => _TherapistDetailScreenState();
}

class _TherapistDetailScreenState extends State<TherapistDetailScreen> with SingleTickerProviderStateMixin {
  bool _showAppointmentForm = false;
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleAppointmentForm() {
    if (!_showAppointmentForm) {
      setState(() {
        _showAppointmentForm = true;
      });
      _animationController.forward();
    } else {
      _closeAppointmentForm();
    }
  }

  void _closeAppointmentForm() {
    _animationController.reverse().then((_) {
      setState(() {
        _showAppointmentForm = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;
    final viewModel = Provider.of<DoctorProfileViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        elevation: 4,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          margin: EdgeInsets.only(bottom: 5),
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
        ),
      ),
      body: Stack(
        children: [
          _buildTherapistDetail(context, isSmallScreen),
          if (_showAppointmentForm)
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return GestureDetector(
                  onVerticalDragEnd: (details) {
                    if (details.primaryVelocity! > 300) {
                      _closeAppointmentForm();
                    }
                  },
                  child: Stack(
                    children: [
                      // Semi-transparent background
                      Opacity(
                        opacity: _opacityAnimation.value * 0.5,
                        child: GestureDetector(
                          onTap: _closeAppointmentForm,
                          child: Container(
                            color: Colors.black,
                          ),
                        ),
                      ),

                      // Appointment form
                      Transform.translate(
                        offset: Offset(0, _slideAnimation.value * size.height),
                        child: child!,
                      ),
                    ],
                  ),
                );
              },
              child: _buildAppointmentForm(context, viewModel, isSmallScreen),
            ),
        ],
      ),
    );
  }

  Widget _buildTherapistDetail(BuildContext context, bool isSmallScreen,) {
    double? rate = double.tryParse(widget.therapist.rate);
    if (rate != null) {
      print("Parsed value: $rate");
    } else {
      print("Invalid input");
    }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 16 : 32,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Text(
              widget.therapist.name,
              style: TextStyle(
                fontSize: isSmallScreen ? 22 : 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF00838F),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '(+20) ${widget.therapist.phonenumber}',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 16),
                Image.asset("images/9946341 1.png",scale: 1.5,)
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'available slots : ${widget.therapist.availableSlots} . ',
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                rate != null ? rate.round() : 0,
                    (starIndex) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Dr ${widget.therapist.name} is a dedicated psychologist specializing in the mental health and well-being of individuals with Down syndrome. With over ${widget.therapist.rate} years of experience, ${widget.therapist.gender == 'Male' ? 'he' : 'she'} provides personalized therapy to help patients develop emotional resilience, social skills, and self-confidence.',
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Location : ${widget.therapist.location} . ',
             style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00838F),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _toggleAppointmentForm,
                child: const Text('Appointment'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentForm(
      BuildContext context,
      DoctorProfileViewModel viewModel,
      bool isSmallScreen,
      ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle indicator for drag
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 10),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 24 : 32,
                  vertical: 16,
                ),
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Center(
                        child: Text(
                          'Appointment',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00838F),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      // Name field
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF00838F),
                        ),
                      ),
                      SizedBox(height: 8),
                      _buildRoundedTextField(
                        controller: viewModel.nameController,
                        hint: 'Enter your name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      // Email field
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF00838F),
                        ),
                      ),
                      SizedBox(height: 8),
                      _buildRoundedTextField(
                        controller: viewModel.emailController,
                        hint: 'Enter your email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      // Phone number field
                      Text(
                        'Phone number',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF00838F),
                        ),
                      ),
                      SizedBox(height: 8),
                      _buildRoundedTextField(
                        controller: viewModel.phoneController,
                        hint: '(+20) Number',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      // Gender dropdown
                      Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF00838F),
                        ),
                      ),
                      SizedBox(height: 8),
                      _buildRoundedDropdown(viewModel),
                      SizedBox(height: 30),

                      // Save button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00838F),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            if (viewModel.submitAppointment(context)) {
                              _closeAppointmentForm();
                            }
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoundedTextField({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[400],
          fontSize: 14,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        filled: true,
        fillColor: Color(0xFFF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Color(0xFF00838F), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildRoundedDropdown(DoctorProfileViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: 'Enter your Gender',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.red, width: 1),
          ),
        ),
        value: viewModel.selectedGender,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select your gender';
          }
          return null;
        },
        items: ['Male', 'Female', 'Other'].map((String gender) {
          return DropdownMenuItem<String>(
            value: gender,
            child: Text(gender),
          );
        }).toList(),
        onChanged: (String? newValue) {
          viewModel.setGender(newValue);
        },
        icon: Icon(
          Icons.arrow_drop_down,
          color: Color(0xFF00838F),
        ),
        dropdownColor: Colors.white,
        isExpanded: true,
      ),
    );
  }
}