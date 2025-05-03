import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> keyform = GlobalKey<FormState>();

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
              elevation: 10,
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white, // لون المربع أصبح أبيض
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/AQ.png", height: 120),
                    const SizedBox(height: 20),
                    Form(
                      key: keyform,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return "Please enter a valid email";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "example@example.com",
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.email, color: Color.fromARGB(255, 9, 118, 228)),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Enter your password",
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.lock, color: Color.fromARGB(255, 9, 118, 228)),
                            ),
                          ),
                          const SizedBox(height: 25),
                          ElevatedButton(
                            onPressed: () {
                              if (keyform.currentState!.validate()) {
                                // بعد نجاح التحقق من المدخلات
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Logging in...")),
                                );

                                // الانتقال لصفحة الهوم بعد تسجيل الدخول
                                Navigator.pushReplacementNamed(context, '/home');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0288D1),
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("Login", style: TextStyle(fontSize: 16, color: Colors.white)),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: const Text(
                              "Don't have an account? Sign Up",
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
}
