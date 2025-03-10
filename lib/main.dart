import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vividdrive/Component/buttomNavbar.dart';
import 'package:vividdrive/screens/SplashScreen/splashscreen.dart';
import 'package:vividdrive/screens/auth/forgetpassword.dart';
import 'package:vividdrive/screens/auth/loginScreen.dart';
import 'package:vividdrive/screens/auth/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:vividdrive/screens/testscreen/testscreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vivid Drive',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                }
                if (snapshot.hasData) {
                  return const Navbar(); // User is signed in
                } else {
                  return LoginScreen(); // User is not signed in
                }
              },
            ),
        '/Signup': (context) => SignUpScreen(),
        '/nav': (context) => const Navbar(),
        '/login': (context) => LoginScreen(),
        '/forgetpassword': (context) => ForgotPasswordScreen(),
        '/testscreen': (context) => TestScreen(),
      },
    );
  }
}
