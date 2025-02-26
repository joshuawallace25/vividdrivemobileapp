import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vividdrive/controller/logincontroller.dart';
import 'package:vividdrive/screens/auth/widget/curvedpainter.dart';
import 'package:vividdrive/screens/auth/widget/textfield.dart';
// Import the login controller

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = Get.put(LoginController()); // Create an instance of LoginController

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomPaint(
              size: Size(screenWidth, screenHeight * 0.3),
              painter: CurvedPainter(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.1),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.1),
                    CustomTextField(
                      hintText: 'Email',
                      icon: Icons.email,
                      controller: emailController,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Password',
                      icon: Icons.lock,
                      isPassword: !_isPasswordVisible,
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
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/login');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Standard ElevatedButton for login
                    ElevatedButton(
                      onPressed: loginController.isLoading.value
                          ? null // Disable the button while loading
                          : () async {
                              await loginController.login(
                                emailController.text,
                                passwordController.text,
                              );
                            },
                      
                      child: loginController.isLoading.value
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                    const SizedBox(height: 20),
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
