import 'package:flutter/material.dart';
import 'package:down_detect/sign%20in.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController Name=TextEditingController();
  TextEditingController Email=TextEditingController();
  TextEditingController Password=TextEditingController();
  TextEditingController Confirm_Password=TextEditingController();

  String? _selectedGender;

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Image.asset("images/logo_white-removebg-preview 2.png"),
                const SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),

                      TextFormField(
                        controller: Name,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical:0,
                              horizontal: 17),
                          hintText: "Enter your name",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 11),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          filled: true,
                          fillColor: Colors.grey[200],

                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      TextFormField(
                        controller: Email,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 3,
                              horizontal: 17),
                          hintText: "Enter your email",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 11),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          filled: true,
                          fillColor: Colors.grey[200],

                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      TextFormField(
                        controller: Password,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 3,
                              horizontal: 17),
                          hintText: "**********",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 11),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          filled: true,
                          fillColor: Colors.grey[200],

                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Confirm password",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      TextFormField(
                        controller:Confirm_Password,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 3,
                              horizontal: 17),
                          hintText: "***********",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 11),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          filled: true,
                          fillColor: Colors.grey[200],

                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Gender",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      _buildGenderDropdown(),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                        ),
                        child: const Text("Sign up", style: TextStyle(
                            color: Colors.white, fontSize: 18)),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? "),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
                              },
                              child: Text(
                                "Login", style: TextStyle(color: Colors.teal),))
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

  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 15, vertical:10 ),
        ),
        hint: const Text(
            "Enter your Gender", style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 10)),
        value: _selectedGender,
        items: ["Male", "Female"].map((String gender) {
          return DropdownMenuItem<String>(
            value: gender,
            child: Text(gender),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedGender = newValue;
          });
        },
        validator: (value) {
          if (value == null) {
            return "Please select a gender";
          }
          return null;
        },
      ),
    );
  }
}