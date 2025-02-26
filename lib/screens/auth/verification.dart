import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vividdrive/screens/auth/widget/curvedpainter.dart';


class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

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
                   SizedBox(height: 20,),
                  SizedBox(height: screenHeight * 0.1),
                 
                Row(
                  children: [
                     GestureDetector(
                      onTap:(){
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back, color: Colors.white,)),
 Text(
                    'Verification',
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ],
                ),
                 
                  SizedBox(height: screenHeight * 0.1),
                  

                  SizedBox(height: 20,),
                  Center(child: Text("A link has been send to your email to verify your account, please Login after Verification!")),
                  Center(child: GestureDetector(
                    onTap: ()=> Get.toNamed('/login'),
                    child: Text("Login", style: TextStyle(fontWeight:FontWeight.bold,color:  Colors.red),))),
                  SizedBox(height: 20),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
