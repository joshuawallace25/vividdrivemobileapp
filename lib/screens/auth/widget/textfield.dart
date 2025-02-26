import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final Widget? suffixIcon; // Optional suffix icon
  final TextEditingController controller; // Required TextEditingController

  // Constructor to accept properties like hintText, icon, isPassword, suffixIcon, and controller
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false, // Default isPassword is false
    this.suffixIcon, 
    required this.controller, // Make sure to pass the controller
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Set the controller
      obscureText: isPassword, // Toggle visibility for password
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon, // Use suffixIcon if provided
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
