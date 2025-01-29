import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../components/header.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import 'order_cc_screen.dart';
import 'order_gc_screen.dart';
import 'order_pipe_screen.dart';
import 'order_channel_screen.dart';
import 'order_angle_screen.dart';
import 'order_heavy_section_screen.dart';
import 'order_frs_screen.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<Product>> _productsFuture;
  final TextEditingController _searchController = TextEditingController();
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
    _searchController.addListener(_onSearchChanged);
    _searchFocus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocus.removeListener(_onFocusChange);
    _searchFocus.dispose();
    super.dispose();
  }

  Future<List<Product>> _loadProducts() async {
    final products = await ApiService().getProducts();
    _allProducts = products;
    _filteredProducts = products;
    return products;
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        return product.name.toLowerCase().contains(query) ||
            product.brand.toLowerCase().contains(query) ||
            product.category.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _onFocusChange() {
    setState(() {}); // Rebuild to update search bar appearance
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Products',
        showBackButton: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primaryColor,
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocus,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Search by name, brand or category...',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white70),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: _searchFocus.hasFocus 
                    ? AppColors.secondaryColor.withOpacity(0.8)
                    : AppColors.secondaryColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              onTap: () {
                if (!_searchFocus.hasFocus) {
                  _searchFocus.requestFocus();
                }
              },
            ),
          ),

          // Products Grid
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 60, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _productsFuture = _loadProducts();
                            });
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (_filteredProducts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_off,
                          size: 60,
                          color: AppColors.primaryColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No products found for "${_searchController.text}"',
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      _productsFuture = _loadProducts();
                    });
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return _buildProductCard(product);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () => _navigateToProductScreen(context, product),
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: Center(
                  child: Text(
                    product.name
                        .split(' ')[0], // Show first word as placeholder
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            // Product Details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Brand: ${product.brand}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          product.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: AppColors.primaryColor,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToProductScreen(BuildContext context, Product product) {
    Widget screen;
    switch (product.category.toUpperCase()) {
      case 'CC':
        screen = OrderCCScreen(product: product);
        break;
      case 'GC':
        screen = OrderGCScreen(product: product);
        break;
      case 'PIPES':
        screen = const OrderPipeScreen();
        break;
      case 'CHANNEL':
        screen = const OrderChannelScreen();
        break;
      case 'ANGLES':
        screen = const OrderAngleScreen();
        break;
      case 'F/R/S':
        screen = const OrderFRSScreen();
        break;
      case 'HEAVY SECTION':
        screen = const OrderHeavySectionScreen();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
