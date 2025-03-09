import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vividdrive/Component/buttomNavbar.dart';
import 'package:vividdrive/screens/SplashScreen/splashscreen.dart';
import 'package:vividdrive/screens/auth/forgetpassword.dart';
import 'package:vividdrive/screens/auth/loginScreen.dart';
import 'package:vividdrive/screens/auth/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vividdrive/screens/auth/verification.dart';
import 'package:vividdrive/screens/testscreen/testscreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures bindings are initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp()); // Now, run the app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner
      title: 'Vivid Drive',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/Signup': (context) =>  SignUpScreen(),
        '/nav': (context) => const Navbar(), 
        '/login': (context) => LoginScreen(),
        '/forgetpassword': (context)=> ForgotPasswordScreen(),
        '/testscreen': (context)=> TestScreen()
      },
    );
  }
}
