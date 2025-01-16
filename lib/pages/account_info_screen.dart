import 'package:flutter/material.dart';
import 'package:kuber_steels/pages/dialog_utils.dart';
import 'package:kuber_steels/services/authentication.dart';
import 'package:kuber_steels/widgets/snackbar.dart';
import '../theme/app_theme.dart';
import '../components/header.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Account Info',
        showBackButton: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Close Icon aligned to the right
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.secondaryColor,
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    _buildInfoField(Icons.person, 'Username', context),
                    const SizedBox(height: 12),
                    _buildInfoField(Icons.email, 'Email ID', context),
                    const SizedBox(height: 12),
                    _buildInfoField(Icons.phone, 'Mobile No.', context),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Action for logout
                        AuthenticationService().logOut();
                        // showSnackBar(context, "User logged off successfully");
                        Navigator.pushReplacementNamed(context, '/login');
                        DialogUtils.showErrorDialog("user logged of successfully");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Log out', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        // Action for privacy policy
                      },
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField(IconData icon, String label, BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
