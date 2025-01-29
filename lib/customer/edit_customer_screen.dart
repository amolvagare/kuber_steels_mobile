import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../components/header.dart';
import '../models/customer.dart';
import '../services/api_service.dart';

class EditCustomerScreen extends StatefulWidget {
  final Customer customer;

  const EditCustomerScreen({super.key, required this.customer});

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _pincodeController;
  late final TextEditingController _gstController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.customer.name);
    _emailController = TextEditingController(text: widget.customer.email);
    _phoneController = TextEditingController(text: widget.customer.phone);
    _addressController = TextEditingController(text: widget.customer.address);
    _cityController = TextEditingController(text: widget.customer.city);
    _pincodeController = TextEditingController(text: widget.customer.pincode);
    _gstController = TextEditingController(text: widget.customer.gstNo);
  }

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

  Future<void> _updateCustomer() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final updatedCustomer = await ApiService().updateCustomer(
        url: widget.customer.url,
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
          const SnackBar(content: Text('Customer updated successfully')),
        );
        Navigator.pop(context, updatedCustomer);
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
        title: 'Edit Customer',
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
              onPressed: _isLoading ? null : _updateCustomer,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Update Customer'),
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