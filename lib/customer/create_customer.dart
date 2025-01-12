import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../components/header.dart'; // Import the custom Header
import '../product/product_page.dart'; // Correct path for ProductPage

class CreateCustomerScreen extends StatelessWidget {
  const CreateCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Create New Customer', // Set the title for the header
        showBackButton: false, // Display the hamburger menu instead of the back arrow
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildTextField('Shop Name', isRequired: true),
                  const SizedBox(height: 10),
                  _buildTextField('First Name', isRequired: true),
                  const SizedBox(height: 10),
                  _buildTextField('Last Name', isRequired: true),
                  const SizedBox(height: 10),
                  _buildTextField('Billing Address', isRequired: true),
                  const SizedBox(height: 10),
                  _buildTextField('Shipping Address', isRequired: true),
                  const SizedBox(height: 10),
                  _buildTextField('Mobile No.', isRequired: true),
                  const SizedBox(height: 10),
                  _buildTextField('Email ID'),
                  const SizedBox(height: 10),
                  _buildTextField('GST No.'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back to the previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'BACK',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to ProductPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {bool isRequired = false}) {
    return TextField(
      decoration: InputDecoration(
        hintText: isRequired ? 'Enter $label *' : 'Enter $label', // Add asterisk for required fields
        hintStyle: const TextStyle(color: Colors.black54), // Lighter color for hint
        filled: true,
        fillColor: AppColors.cardColor, // Background color for input field
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      style: const TextStyle(color: Colors.black), // Black text for input
    );
  }
}
