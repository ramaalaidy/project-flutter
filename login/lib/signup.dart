import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB2EBF2), // أزرق فاتح كالماء
              Color.fromARGB(255, 35, 104, 215), // سماوي ناعم
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              color: Colors.white,
              elevation: 10,
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/AQ.png", height: 120),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          buildTextField("First Name", "Enter your first name"),
                          const SizedBox(height: 15),
                          buildTextField("Last Name", "Enter your last name"),
                          const SizedBox(height: 15),
                          buildTextField(
                            "Email",
                            "example@example.com",
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return "Please enter a valid email";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          buildTextField(
                            "Password",
                            "Enter password",
                            obscureText: true,
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a password";
                              } else if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          buildTextField(
                            "Confirm Password",
                            "Re-type your password",
                            obscureText: true,
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please confirm your password";
                              } else if (value != _passwordController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Account Created Successfully")),
                                );
                                Future.delayed(const Duration(seconds: 1), () {
                                  Navigator.pushReplacementNamed(context, '/login');
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0288D1),
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("Sign Up", style: TextStyle(fontSize: 16, color: Colors.white)),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Already have an account? Login",
                              style: TextStyle(color: Color(0xFF006064)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint,
      {bool obscureText = false,
      TextEditingController? controller,
      TextInputType? keyboardType,
      String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "Please enter $label";
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Icon(
          label == "Email"
              ? Icons.email
              : label.contains("Password")
                  ? Icons.lock
                  : Icons.person,
          color: const Color.fromARGB(255, 9, 118, 228),
        ),
      ),
    );
  }
}
