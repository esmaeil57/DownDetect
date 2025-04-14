import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'sign_up_screen.dart';
import 'main_navigation_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0E6C73),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1BCCD9), Color(0xFF0E6C73)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.15, 0.78],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Image.asset("images/logo_white-removebg-preview 2.png"),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal),
                    ),
                    const SizedBox(height: 15),
                    const Text("Email", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 3),
                    TextField(
                      controller: viewModel.emailController,
                      decoration: _inputDecoration("Enter your email"),
                    ),
                    const SizedBox(height: 15),
                    const Text("Password", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 3),
                    TextField(
                      controller: viewModel.passwordController,
                      obscureText: true,
                      decoration: _inputDecoration("**********"),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Forgot Password?", style: TextStyle(color: Colors.teal, fontSize: 12)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: ()
                        {
                          // 🟢 Navigate to main app
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
                          );
                        },
                        child: const Text("Login", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                          },
                          child: const Text(" Sign up", style: TextStyle(color: Colors.teal)),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      filled: true,
      fillColor: Colors.grey[200],
      hintText: hint,
      hintStyle: const TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
    );
  }
}
