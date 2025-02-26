import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final EdgeInsets? padding;
  final double? fontSize;
  final double borderRadius;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textColor,
    this.padding,
    this.fontSize,
    required this.borderRadius,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: screenWidth * 0.9, // Button width set to 90% of the screen width
          padding: padding ??
              EdgeInsets.symmetric(
                vertical: screenHeight * 0.02, // 2% of screen height
              ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Icon(
                  icon,
                  color: textColor,
                  size: screenHeight * 0.025, // Responsive icon size
                ),
              if (icon != null)
                SizedBox(width: screenWidth * 0.02), // Spacer between icon and text
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize ?? screenHeight * 0.02, // Responsive font size
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
