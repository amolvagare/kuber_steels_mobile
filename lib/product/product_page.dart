import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../components/header.dart';
import '../customer/customer_details.dart';
import 'order_cc_screen.dart';
import 'order_gc_screen.dart';
import 'order_pipe_screen.dart';
import 'order_channel_screen.dart';
import 'order_angle_screen.dart';
import 'order_heavy_section_screen.dart';
import 'order_frs_screen.dart';

class ProductPage extends StatelessWidget {
  // List of products with their names, image URLs, and screen routes
  final List<Map<String, dynamic>> products = [
    {
      'name': 'CC',
      'imageUrl': 'https://img.freepik.com/free-photo/interior-view-steel-factory_1359-120.jpg?t=st=1730777549~exp=1730781149~hmac=c0ac916224178a6633ffc4e0acd263e1e86d95b7d72fc1244429eaf0e22b51db&w=900',
      'screen': const OrderCCScreen(),
    },
    {
      'name': 'GC',
      'imageUrl': 'https://img.freepik.com/free-photo/arc-welding-steel-construction-site_2831-696.jpg?t=st=1730777622~exp=1730781222~hmac=7027262ab8612ec0cd5a0361964d6c52ae1e45830ccecf75d4738c4b5b33f3a5&w=740',
      'screen': const OrderGCScreen(),
    },
    {
      'name': 'Pipes',
      'imageUrl': 'https://img.freepik.com/free-photo/portrait-young-worker-hard-hat-large-metalworking-plant_146671-19572.jpg?t=st=1730777655~exp=1730781255~hmac=ec43cb8f2142e0dc84fafd79a513155d962b4d6afdc7e225d63bb8e0acf35b8c&w=900',
      'screen': const OrderPipeScreen(),
    },
    {
      'name': 'Channel',
      'imageUrl': 'https://img.freepik.com/free-photo/male-mechanic-working-his-workshop_23-2148970739.jpg?t=st=1730777680~exp=1730781280~hmac=84ab8056ff85aaef786120ce40c4acb57241573550f8fa01e6c52945dce51a7f&w=900',
      'screen': const OrderChannelScreen(),
    },
    {
      'name': 'Angles',
      'imageUrl': 'https://img.freepik.com/free-photo/arc-welding-steel-construction-site_2831-686.jpg?t=st=1730777702~exp=1730781302~hmac=73c18fbbae5dd7b09c653fc65f9dabd7886ae232d923f0c5e440351d884181c8&w=740',
      'screen': const OrderAngleScreen(),
    },
    {
      'name': 'F/R/S',
      'imageUrl': 'https://img.freepik.com/free-photo/interior-view-steel-factory_1359-117.jpg?t=st=1730777462~exp=1730781062~hmac=3320d4c2c91f56978dc4ca24cc85cb83a95035b66331621f8c04d029eb576246&w=900',
      'screen': const OrderFRSScreen(),
    },
    {
      'name': 'Heavy Section',
      'imageUrl': 'https://img.freepik.com/free-photo/aged-caucasian-blacksmith-wearing-safety-apron-gloves-forging-steel-anvil-with-heavy-hammer-manual-work-forge-manufacturing-concept_7502-9477.jpg?t=st=1730777767~exp=1730781367~hmac=78ad1c22073ad8ea0b35535b91e4e50c70739593f79c877e64428a06d102c207&w=900',
      'screen': const OrderHeavySectionScreen(),
    },
  ];

  ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'KUBER STEEL INDUSTRIES',
        showBackButton: false,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Display 3 items per row
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the respective product screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => product['screen']),
                      );
                    },
                    child: Column(
                      children: [
                        Text(
                          product['name']!,
                          style: const TextStyle(
                            color: Colors.black, // Dark text color for readability
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: AppColors.cardColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product['imageUrl']!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                );
                              },
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const CustomerDetailsScreen()),
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
                    'BACK',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Action for NEXT button
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
