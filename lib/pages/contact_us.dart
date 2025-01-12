import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../components/header.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Contact Us',
        showBackButton: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: AppColors.primaryColor, // Dark card color for contrast
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Get in Touch',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text for high contrast
                  ),
                ),
                const SizedBox(height: 16),
                _buildContactInfo(
                  icon: Icons.location_on,
                  title: 'Visit Us',
                  details: '123 Steel Industrial Area\nMumbai, Maharashtra 400001',
                ),
                const Divider(color: Colors.white24), // Light divider color for contrast
                _buildContactInfo(
                  icon: Icons.phone,
                  title: 'Call Us',
                  details: '+91 98765 43210\n+91 98765 43211',
                ),
                const Divider(color: Colors.white24),
                _buildContactInfo(
                  icon: Icons.email,
                  title: 'Email Us',
                  details: 'info@kubersteel.com\nsupport@kubersteel.com',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build individual contact sections
  Widget _buildContactInfo({required IconData icon, required String title, required String details}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white, // Light background for icon for contrast
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primaryColor), // Dark icon color
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White color for titles
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70, // Slightly lighter white for details
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
