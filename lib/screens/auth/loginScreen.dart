import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vividdrive/screens/auth/widget/curvedpainter.dart';

import 'package:vividdrive/screens/auth/widget/custom_button.dart';
import 'package:vividdrive/screens/auth/widget/textfield.dart';

/// A stateless widget representing the Login screen.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false; // Track password visibility
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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

                    // Login Text
                    Text(
                      'Login',
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
                      hintText: 'Email',
                      icon: Icons.email, controller: emailController,
                      // Increased font size for readability
                    ),
                    const SizedBox(height: 10),

                    // Password TextField with visibility toggle
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
                      ),
                      controller: passwordController,
                    ),

                    const SizedBox(height: 20),

                    // Remember Me Toggle and Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Remember Me Switch
                            /* Switch(
                              value: _isRememberMeChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isRememberMeChecked = value;
                                });
                              },
                              activeColor:
                                  Colors.red, // Red color when toggled on
                              inactiveThumbColor:
                                  Colors.white, // White button when off
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Remember Me',
                              style: TextStyle(fontSize: 16),
                            ), */
                          ],
                        ),

                        // Forgot Password Button
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/forgetpassword');
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Login Button
                    CustomButton(
                      text: 'Login',
                      onPressed: () {
                        Get.toNamed('/nav');
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      fontSize: screenWidth * 0.05,
                      borderRadius: 10,
                    ),

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

                    // Google Login Button

                    // Sign Up redirection text
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Do not have an account yet?',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(width: 3),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('/Signup');
                            },
                            child: const Text(
                              'Sign Up',
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
