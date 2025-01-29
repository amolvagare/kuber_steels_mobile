import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../components/header.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class OrderGCScreen extends StatefulWidget {
  final Product product;

  const OrderGCScreen({super.key, required this.product});

  @override
  State<OrderGCScreen> createState() => _OrderGCScreenState();
}

class _OrderGCScreenState extends State<OrderGCScreen> {
  ProductVariant? selectedVariant;
  late Future<Product> _productDetailsFuture;

  @override
  void initState() {
    super.initState();
    _productDetailsFuture = ApiService().getProductDetails(widget.product.id);
  }

  void _addToCart() {
    if (selectedVariant != null) {
      context.read<CartProvider>().addToCart(widget.product, selectedVariant!);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added to cart')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a variant')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Order GC Sheet',
        showBackButton: true,
      ),
      body: FutureBuilder<Product>(
        future: _productDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final product = snapshot.data!;
          final variants = product.variants ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Product: ${product.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                // Color dropdown
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Color'),
                  items: variants
                      .map((v) => DropdownMenuItem(
                            value: v.color.colorName,
                            child: Text(v.color.colorName),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedVariant = variants.firstWhere((v) => v.color.colorName == value);
                    });
                  },
                ),

                // Size dropdown
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Size'),
                  items: variants
                      .map((v) => DropdownMenuItem(
                            value: v.size.sizeValue,
                            child: Text(v.size.sizeValue),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedVariant = variants.firstWhere((v) => v.size.sizeValue == value);
                    });
                  },
                ),

                // Thickness dropdown
                DropdownButtonFormField<double>(
                  decoration: const InputDecoration(labelText: 'Thickness'),
                  items: variants
                      .map((v) => DropdownMenuItem(
                            value: v.thickness.thicknessValue,
                            child: Text('${v.thickness.thicknessValue}'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedVariant = variants.firstWhere((v) => v.thickness.thicknessValue == value);
                    });
                  },
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addToCart,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDropdownField(String label) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600), // Darker text
        filled: true,
        fillColor: AppColors.cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: ['Option 1', 'Option 2', 'Option 3']
          .map((option) => DropdownMenuItem(
        value: option,
        child: Text(option),
      ))
          .toList(),
      onChanged: (value) {},
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget _buildInputField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600), // Darker text
        filled: true,
        fillColor: AppColors.cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(context, 'ADD', AppColors.primaryColor, () {
          // Add to cart action
        }),
        _buildActionButton(context, 'PREVIEW', AppColors.secondaryColor, () {
          // Preview action
        }),
        _buildActionButton(context, 'PRODUCT LIST', AppColors.primaryColor, () {
          Navigator.pop(context);
        }),
        _buildActionButton(context, 'CANCEL', Colors.red, () {
          Navigator.pop(context);
        }),
      ],
    );
  }

  Widget _buildActionButton(
      BuildContext context, String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
