import 'package:flutter/material.dart';
import 'package:kuber_steels/product/product_list.dart';
import 'home_screen.dart';
import 'contact_us.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                print("Navigating to HomeScreen");
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text("Products"),
              onTap: () {
                print("Navigating to ProductList");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductList(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.headset_mic),
              title: const Text("Contact Us"),
              onTap: () {
                print("Navigating to ContactUsPage");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
