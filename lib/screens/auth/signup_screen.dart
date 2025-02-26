import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vividdrive/controller/signup_controller.dart';
import 'package:vividdrive/screens/auth/widget/curvedpainter.dart';

import 'package:vividdrive/screens/auth/widget/textfield.dart';


/// A stateless widget representing the Sign Up screen.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> { 
  final SignUpController signUpController = Get.put(SignUpController());
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive layouts
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Custom painted curved background
            CustomPaint(
              size: Size(screenWidth,
                  screenHeight * 0.3), // Dynamic height based on screen size
              painter: CurvedPainter(),
            ),
            // Main content of the form
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      screenWidth * 0.05), // 5% padding from left and right
              child: SingleChildScrollView(
                // Ensure scrollability on smaller screens
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Space between top and content
                    SizedBox(height: screenHeight * 0.1),

                    // Sign Up Text
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: screenWidth * 0.08, // Dynamic font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    // Space between title and text fields
                    SizedBox(height: screenHeight * 0.1),

                    // Form fields
                    CustomTextField(
                      hintText: 'Full name',
                      icon: Icons.person,
                        controller: fullNameController,
                      // Increased font size for readability
                    ),
                    const SizedBox(height: 10),
                     CustomTextField(
                      hintText: 'Email',
                      icon: Icons.email, controller:  emailController,
                      // Increased font size for readability
                    ),
                    const SizedBox(height: 10),
                   
                    CustomTextField(
                      hintText: 'Password',
                      icon: Icons.lock,
                      isPassword:
                          !_isPasswordVisible, // Toggle password visibility
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ), controller:  passwordController,
                    ),
                    const SizedBox(height: 20),

                    // Sign Up Button
                     Obx(() => ElevatedButton(
                  onPressed: signUpController.isLoading.value
                      ? null
                      : () {
                          signUpController.signUp(
                            fullNameController.text.trim(),
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        },
                  child: Text(signUpController.isLoading.value ? 'Signing Up...' : 'Sign Up'),
                )),
                 

                    // Space between buttons
                    const SizedBox(height: 20),

                    // Divider with "or"
                    Row(
                      children: [
                        const Expanded(child: Divider(thickness: 1)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('or'),
                        ),
                        const Expanded(child: Divider(thickness: 1)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Login redirection text
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(width: 3),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/login');
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

