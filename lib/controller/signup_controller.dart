import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;
  var showResendButton = false.obs; // To control the visibility of the resend button
  var timeLeft = 50.obs; // Time remaining before showing the resend button

  Future<void> signUp(String fullName, String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'fullName': fullName,
        'email': email,
        'role': 'user',
        'createdAt': FieldValue.serverTimestamp(),
      });

      await userCredential.user?.sendEmailVerification();
      Get.defaultDialog(
        title: "Email Verification",
        content: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text("Please verify your email to continue."),
            Obx(() {
              if (showResendButton.value) {
                return ElevatedButton(
                  onPressed: _resendVerificationEmail,
                  child: Text("Resend Verification Email"),
                );
              } else {
                return Text("Please wait for ${timeLeft.value}s to resend.");
              }
            }),
          ],
        ),
        barrierDismissible: false,
      );

      // Start the countdown timer
      _startResendTimer();

      await _checkEmailVerification();
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // Method to start the countdown timer
  void _startResendTimer() {
    Future.delayed(Duration(seconds: 50), () {
      showResendButton.value = true; // Show the resend button after 50 seconds
    });

    // Countdown to update the time remaining
    for (int i = 50; i > 0; i--) {
      Future.delayed(Duration(seconds: 1), () {
        timeLeft.value = i;
      });
    }
  }

  // Method to resend the email verification
  Future<void> _resendVerificationEmail() async {
    try {
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        Get.snackbar("Resend", "Verification email sent again.", backgroundColor: Colors.green, colorText: Colors.white);
        showResendButton.value = false; // Hide the resend button again
        timeLeft.value = 50; // Reset the timer
        _startResendTimer(); // Restart the timer
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> _checkEmailVerification() async {
    User? user = _auth.currentUser;
    while (user != null && !user.emailVerified) {
      await Future.delayed(const Duration(seconds: 3));
      await user.reload();
      user = _auth.currentUser;
    }
    Get.back(); // Close the loading dialog

    // Show success dialog when email is verified
    Get.defaultDialog(
      title: "Email Verified",
      content: Column(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 40,
          ),
          SizedBox(height: 10),
          Text("Your email has been verified."),
        ],
      ),
      barrierDismissible: false,
    );

    // Wait for a brief moment before navigating
    await Future.delayed(Duration(seconds: 2));

    // Navigate to the home screen after verification
    Get.offAllNamed('/nav');
  }
}
