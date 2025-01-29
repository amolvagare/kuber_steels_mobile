import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../components/header.dart';
import 'customer_details.dart';
import 'create_customer.dart';
import 'dart:async';
import '../models/customer.dart';
import '../services/api_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomerSelectionScreen extends StatefulWidget {
  const CustomerSelectionScreen({super.key});

  @override
  State<CustomerSelectionScreen> createState() => _CustomerSelectionScreenState();
}

class _CustomerSelectionScreenState extends State<CustomerSelectionScreen> {
  late Future<List<Customer>> _customersFuture;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  Timer? _debounce;
  Customer? _selectedCustomer;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _customersFuture = _loadCustomers();
    _searchController.addListener(_onSearchChanged);
    _searchFocus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocus.removeListener(_onFocusChange);
    _searchFocus.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<List<Customer>> _loadCustomers() {
    return ApiService().getCustomers(
      searchQuery: _searchController.text.isEmpty ? null : _searchController.text,
    );
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _customersFuture = _loadCustomers();
      });
    });
  }

  void _onFocusChange() {
    setState(() {});
  }

  Future<void> _onRefresh() async {
    try {
      setState(() {
        _customersFuture = _loadCustomers();
      });
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }

  void _navigateToCreateCustomer() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateCustomerScreen()),
    );
    
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: const Header(
        title: 'Customers',
        showBackButton: false,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              focusNode: _searchFocus,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => _searchController.clear(),
                      )
                    : null,
                hintText: 'Search by Name, Mobile, or Shop Name...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: RefreshConfiguration(
                headerBuilder: () => const WaterDropHeader(),
                child: SmartRefresher(
                  enablePullDown: true,
                  header: const WaterDropHeader(),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: FutureBuilder<List<Customer>>(
                    future: _customersFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }

                      final customers = snapshot.data!;
                      if (customers.isEmpty) {
                        return const Center(
                          child: Text('No customers found'),
                        );
                      }

                      return ListView.builder(
                        itemCount: customers.length,
                        itemBuilder: (context, index) {
                          final customer = customers[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              title: Row(
                                children: [
                                  const Icon(Icons.store, color: AppColors.primaryColor),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      customer.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.phone, size: 16, color: Colors.grey),
                                        const SizedBox(width: 4),
                                        Text(customer.phone),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            '${customer.address}, ${customer.city} - ${customer.pincode}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.arrow_forward_ios, color: AppColors.primaryColor),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CustomerDetailsScreen(customer: customer),
                                    ),
                                  );
                                },
                              ),
                              selected: _selectedCustomer?.url == customer.url,
                              selectedTileColor: AppColors.primaryColor.withOpacity(0.1),
                              onTap: () {
                                setState(() {
                                  _selectedCustomer = customer;
                                });
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _navigateToCreateCustomer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('New +'),
                ),
                ElevatedButton(
                  onPressed: _selectedCustomer == null ? null : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerDetailsScreen(customer: _selectedCustomer!),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('NEXT'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}