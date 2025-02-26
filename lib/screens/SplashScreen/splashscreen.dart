import 'package:flutter/material.dart';
import 'dart:async';  // For delaying the transition

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay for 3 seconds before navigating to HomeScreen
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueAccent, Colors.blue],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header text
             /*  Image.assets('assets') */
              Text(
                "Vivid Drive",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              // Sub-text
              Text(
                "Your all in one Storage",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
