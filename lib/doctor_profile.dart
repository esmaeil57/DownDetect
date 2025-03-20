import 'package:flutter/material.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9), // Light background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Doctor Image
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ClipRRect(
                  child: Image.asset(
                    'images/ai-generative-portrait-of-confident-male-doctor-in-white-coat-and-stethoscope-standing-with-arms-crossed-and-looking-at-camera-photo 4.jpg', // Replace with your image path
                    fit: BoxFit.cover,
                    height: 400,
                    width: double.infinity,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Doctor Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr Sima Alpha',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '(+20) 1056422890',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Spacer(),
                        // Call Button
                        GestureDetector(
                          onTap: () {
                            // Implement your call logic here
                          },
                          child: Container(
                            child: Image.asset("images/9946341 1.png"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    // Rating Stars
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(Icons.star, color: Colors.amber, size: 24);
                      }),
                    ),
                    SizedBox(height: 16),

                    // Description
                    Text(
                      'Dr Sima Alpha is a dedicated psychologist specializing in the mental health and well-being of individuals with Down syndrome. With over 6 years of experience, he provides personalized therapy to help patients develop emotional resilience, social skills, and self-confidence.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 30),

                    // Appointment Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: AppointmentForm(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Color(0xFF00796B),
                        ),
                        child: Text(
                          'Appointment',
                          style: TextStyle(color: Colors.white,fontSize: 18),
                        ),
                      )

                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class AppointmentForm extends StatefulWidget {
  const AppointmentForm({super.key});

  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  final _formKey = GlobalKey<FormState>();
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width:double.infinity, // 80% of screen width
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              '        Appointment',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00796B),
              ),
            ),
            SizedBox(height: 20),

            // Phone Number Field
            Text(
              "Name",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),

            // Name Field
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical:0,
                    horizontal: 17),
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Enter your name',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 11),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Phone Number Field
            Text(
              "Email",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),

            // Email Field
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical:0,
                    horizontal: 17),
                hintText: 'Enter your email',
                filled: true,
                fillColor: Colors.grey[200],
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 11),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Phone Number Field
            Text(
              "Phone number",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),

            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical:0,
                    horizontal: 17),
                hintText: '(+20) Number',
                filled: true,
                fillColor: Colors.grey[200],
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 11),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),

            // Phone Number Field
            Text(
              "Gender",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),

            // Gender Dropdown
            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              hint: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enter your gender",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 11,
                    // Optional, to make hint text grey
                  ),
                ),
              ),
              items: ['Male', 'Female'].map((gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),

            SizedBox(height: 40),

            // Save Button
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  Navigator.pop(context); // Close the dialog
                }
              },
              style: ElevatedButton.styleFrom(
                alignment: Alignment.topLeft,
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Color(0xFF00796B),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                '          Save',
                style: TextStyle( color: Colors.white,
                    fontSize: 18),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

