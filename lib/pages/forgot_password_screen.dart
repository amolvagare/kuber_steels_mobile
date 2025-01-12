import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor, // Theme color for AppBar
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Contrast color for the icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the login screen
          },
        ),
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white), // Light color for text on dark AppBar
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white, // Light background color
      body: Center(
        child: Card(
          color: AppColors.primaryColor, // Darker card background color for contrast
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.email,
                  color: Colors.white, // White icon for contrast on dark card
                  size: 40,
                ),
                SizedBox(height: 16),
                Text(
                  'Need Help? Contact Admin',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White color for text on dark card
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Divider(color: Colors.white54), // Lighter divider for separation
                SizedBox(height: 10),
                Text(
                  'Email: info@polynovators.com',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // White text color for contrast
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Phone: +1-800-123-4567', // Example contact number
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white, // White text color for contrast
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
