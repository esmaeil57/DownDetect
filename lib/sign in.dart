import 'package:flutter/material.dart';
import 'package:down_detect/sign%20up.dart';

import 'home page.dart';

class LoginScreen extends StatefulWidget {
  static const routeName='home';

  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController Email=TextEditingController();
  TextEditingController Password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF0E6C73) ,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1BCCD9),Color(0xFF0E6C73)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 90),
           Image.asset("images/logo_white-removebg-preview 2.png"),
            const SizedBox(height: 30),
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
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.teal,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  TextField(
                    controller:Email,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0,
                          horizontal: 20),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 11),
                      hintText: "Enter your email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Password",
                    style: TextStyle(
                      color: Colors.teal,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 3),
                  TextField(
                    controller:Password,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0,
                          horizontal: 20),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "**********",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 11),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.teal, fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 30),
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen()));
                        },
                      child: const Text("Login", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont have an account?"),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpScreen()));
                          },
                          child: Text(
                            " Sign up", style: TextStyle(color: Colors.teal),))

                    ],
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    ))
    );
  }
}