import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../components/header.dart';
import '../product/product_page.dart';
import '../product/previous_order.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Customer Details',
        showBackButton: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetail("Shop Name*", "ABC Steel Supplier"),
            _buildDetail("First Name*", "John"),
            _buildDetail("Last Name*", "Doe"),
            _buildDetail("Billing Address*", "123 Industrial Area, Mumbai"),
            _buildDetail("Shipping Address*", "123 Industrial Area, Mumbai"),
            _buildDetail("Mobile No.*", "+91 98765 43210"),
            _buildDetail("Email ID*", "john.doe@example.com"),
            _buildDetail("GST NO.*", "27AAEPM1234Q1Z5"),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PreviousOrderPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor, // Dark button for contrast
                    foregroundColor: Colors.white, // White text color
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'PREV. ORDER',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor, // Dark button for contrast
                    foregroundColor: Colors.white, // White text color
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'NEW ORDER',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build each detail in a white box with black text
  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white, // White background for detail box
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black, // Black text for label
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Black text for value
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
