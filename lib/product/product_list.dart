import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProductList extends StatelessWidget {
  // Sample product data with icons and names
  final List<Map<String, String>> products = [
    {'name': 'CC', 'icon': 'assets/icons/cc_icon.png'},
    {'name': 'GC', 'icon': 'assets/icons/gc_icon.png'},
    {'name': 'Pipes', 'icon': 'assets/icons/pipes_icon.png'},
    {'name': 'Channel', 'icon': 'assets/icons/channel_icon.png'},
    {'name': 'Angles', 'icon': 'assets/icons/angles_icon.png'},
    {'name': 'R/R/S', 'icon': 'assets/icons/rrs_icon.png'},
    {'name': 'Heavy Section', 'icon': 'assets/icons/heavy_section_icon.png'},
  ];

  ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order for Mr. Gaurav'),
        backgroundColor: AppColors.primaryColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Three items per row
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      // Action when a product is selected
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: AppColors.cardColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            product['icon']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product['name']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
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
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action for "Next" button
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
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
}
