import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../components/header.dart'; // Import the custom Header
import '../product/product_page.dart'; // Correct path for ProductPage
import '../services/api_service.dart';

class CreateCustomerScreen extends StatefulWidget {
  const CreateCustomerScreen({super.key});

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _gstController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    _gstController.dispose();
    super.dispose();
  }

  Future<void> _createCustomer() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final customer = await ApiService().createCustomer(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        address: _addressController.text,
        city: _cityController.text,
        pincode: _pincodeController.text,
        gstNo: _gstController.text,
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Customer created successfully')),
        );
        Navigator.pop(context, customer); // Return the created customer
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Create New Customer',
        showBackButton: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildTextField(
              controller: _nameController,
              label: 'Name',
              validator: (v) => v?.isEmpty ?? true ? 'Name is required' : null,
            ),
            _buildTextField(
              controller: _emailController,
              label: 'Email',
              validator: (v) => v?.isEmpty ?? true ? 'Email is required' : null,
            ),
            _buildTextField(
              controller: _phoneController,
              label: 'Phone',
              validator: (v) => v?.isEmpty ?? true ? 'Phone is required' : null,
            ),
            _buildTextField(
              controller: _addressController,
              label: 'Address',
              validator: (v) => v?.isEmpty ?? true ? 'Address is required' : null,
            ),
            _buildTextField(
              controller: _cityController,
              label: 'City',
              validator: (v) => v?.isEmpty ?? true ? 'City is required' : null,
            ),
            _buildTextField(
              controller: _pincodeController,
              label: 'Pincode',
              validator: (v) => v?.isEmpty ?? true ? 'Pincode is required' : null,
            ),
            _buildTextField(
              controller: _gstController,
              label: 'GST No',
              validator: (v) => v?.isEmpty ?? true ? 'GST No is required' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _createCustomer,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Create Customer'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}
