/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vividdrive/screens/auth/loginScreen.dart';
import 'package:vividdrive/screens/auth/widget/custom_button.dart';
import 'package:vividdrive/screens/auth/widget/textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

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
                        'Forget Password',
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
                    hintText: 'Phone number',
                    icon: Icons.phone, controller: null,
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Send Password link',
                    onPressed: () {
                      // Show the popup dialog
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
                    },
                    color: Colors.blue,
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
 */