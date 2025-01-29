import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../components/header.dart';
import '../product/product_page.dart';
import '../product/previous_order.dart';
import '../models/customer.dart';
import '../customer/edit_customer_screen.dart';
import '../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final Customer customer;

  const CustomerDetailsScreen({
    super.key,
    required this.customer,
  });

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  late Customer _customer;

  @override
  void initState() {
    super.initState();
    _customer = widget.customer;
    // Set current customer for cart
    context.read<CartProvider>().setCustomer(_customer.url);
  }

  @override
  void dispose() {
    // Clear current customer when leaving the screen
    context.read<CartProvider>().clearCustomer();
    super.dispose();
  }

  void _navigateToEdit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCustomerScreen(customer: widget.customer),
      ),
    );
    
    if (result != null) {
      setState(() {
        _customer = result as Customer;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: 'Customer Details',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _navigateToEdit,
          ),
        ],
      ),
      backgroundColor: AppColors.backgroundColor,
      // Customer Details Screen
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Customer Profile Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _customer.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _customer.email,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Details Section
              const Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 12),
              _buildDetail(Icons.phone, "Mobile", _customer.phone),
              _buildDetail(Icons.location_on, "Address", _customer.address),
              _buildDetail(Icons.location_city, "City", _customer.city),
              _buildDetail(Icons.pin_drop, "Pincode", _customer.pincode),
              _buildDetail(Icons.receipt, "GST No.", _customer.gstNo),

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PreviousOrderPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.history),
                      label: const Text('Previous Orders'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text('New Order'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetail(IconData icon, String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryColor),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
