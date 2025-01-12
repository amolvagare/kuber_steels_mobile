import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../pages/account_info_screen.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showAccountIcon;

  const Header({super.key, 
    required this.title,
    this.showBackButton = false,
    this.showAccountIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      )
          : IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          _showSupportDrawer(context); // Show drawer when menu is clicked
        },
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      actions: showAccountIcon
          ? [
        IconButton(
          icon: const Icon(Icons.account_circle, color: Colors.white),
          onPressed: () {
            _showAccountInfoDialog(context); // Open account info screen
          },
        ),
      ]
          : [],
    );
  }

  // Drawer menu for navigation
  void _showSupportDrawer(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: 0.7, // 70% of the screen width
            child: Material(
              color: AppColors.backgroundColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    color: AppColors.primaryColor, // Dark background for title
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      "KUBER STEEL INDUSTRIES", // Main title inside the drawer
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White text color
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home, color: AppColors.primaryColor),
                    title: const Text("Home"),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.storage, color: AppColors.primaryColor),
                    title: const Text("Products"),
                    onTap: () {
                      Navigator.pushNamed(context, '/products');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.headset_mic, color: AppColors.primaryColor),
                    title: const Text("Contact Us"),
                    onTap: () {
                      Navigator.pushNamed(context, '/contact-us');
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Function to open account info screen
  void _showAccountInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const AccountInfoScreen(), // Opens AccountInfoScreen
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
