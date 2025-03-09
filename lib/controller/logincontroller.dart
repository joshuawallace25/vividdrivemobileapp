import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  // Login method to authenticate users
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      // Sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if the email is verified
      if (userCredential.user != null && userCredential.user!.emailVerified) {
        // Proceed to the next screen if email is verified
        Get.offAllNamed('/testscreen');
      } else {
        // If email is not verified, show an alert and log out the user
        await _auth.signOut();
        Get.snackbar("Error", "Please verify your email to continue.",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
