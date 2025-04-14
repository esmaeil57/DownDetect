import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/signup_viewmodel.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignUpViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0E6C73),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1BCCD9), Color(0xFF0E6C73)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Image.asset("images/logo_white-removebg-preview 2.png"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text("Name",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal)),
                      TextFormField(
                        controller: viewModel.nameController,
                        decoration: _fieldDecoration("Enter your name"),
                      ),
                      const SizedBox(height: 10),
                      const Text("Email",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal)),
                      TextFormField(
                        controller: viewModel.emailController,
                        decoration: _fieldDecoration("Enter your email"),
                      ),
                      const SizedBox(height: 10),
                      const Text("Password",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal)),
                      TextFormField(
                        controller: viewModel.passwordController,
                        obscureText: true,
                        decoration: _fieldDecoration("**********"),
                      ),
                      const SizedBox(height: 10),
                      const Text("Confirm password",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal)),
                      TextFormField(
                        controller: viewModel.confirmPasswordController,
                        obscureText: true,
                        decoration: _fieldDecoration("***********"),
                      ),
                      const SizedBox(height: 12),
                      const Text("Gender",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal)),
                      _buildGenderDropdown(viewModel),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => viewModel.signUp(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                        ),
                        child: const Text("Sign up",
                            style:
                            TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                  const LoginScreen()));
                            },
                            child: const Text("Login",
                                style: TextStyle(color: Colors.teal)),
                          )
                        ],
                      )
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

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      contentPadding:
      const EdgeInsets.symmetric(vertical: 0, horizontal: 17),
      hintText: hint,
      hintStyle: const TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
      filled: true,
      fillColor: Colors.grey[200],
    );
  }

  Widget _buildGenderDropdown(SignUpViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
        hint: const Text("Enter your Gender",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10)),
        value: viewModel.selectedGender,
        items: ["Male", "Female"].map((String gender) {
          return DropdownMenuItem<String>(
            value: gender,
            child: Text(gender),
          );
        }).toList(),
        onChanged: (String? newValue) {
          viewModel.setGender(newValue);
        },
      ),
    );
  }
}
