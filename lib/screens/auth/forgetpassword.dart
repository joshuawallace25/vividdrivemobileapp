import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vividdrive/screens/auth/loginScreen.dart';
import 'package:vividdrive/screens/auth/widget/curvedpainter.dart';
import 'package:vividdrive/screens/auth/widget/custom_button.dart';
import 'package:vividdrive/screens/auth/widget/textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  Future<void> sendPasswordResetLink() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      // Show success dialog
      Get.dialog(
        AlertDialog(
          title: Text('Success'),
          content: Text(
            'Password link has been sent to your email successfully.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Navigate to the login screen
                Get.offAll(() => LoginScreen());
              },
              child: Text('Okay'),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      // Handle errors (e.g. email not found, invalid format)
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.1),
                  CustomTextField(
                    hintText: 'Enter your email',
                    icon: Icons.email,
                    controller: emailController,
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Send Password link',
                    onPressed: () {
                      // Check if email is entered
                      if (emailController.text.trim().isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Please enter your email.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                      sendPasswordResetLink();
                    },
                    color: Colors.black,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    fontSize: screenWidth * 0.05,
                    borderRadius: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
