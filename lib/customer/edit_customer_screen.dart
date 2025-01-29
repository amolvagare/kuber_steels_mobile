import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../components/header.dart';

class EditCustomerScreen extends StatefulWidget {
  final Customer customer;

  const EditCustomerScreen({super.key, required this.customer});

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _pincodeController;
  late TextEditingController _gstController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(
        title: 'Edit Customer',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField('Name', _nameController, Icons.person),
            _buildTextField('Email', _emailController, Icons.email),
            _buildTextField('Phone', _phoneController, Icons.phone),
            _buildTextField('Address', _addressController, Icons.location_on),
            _buildTextField('City', _cityController, Icons.location_city),
            _buildTextField('Pincode', _pincodeController, Icons.pin_drop),
            _buildTextField('GST No.', _gstController, Icons.receipt),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final editedCustomer = Customer(
                  url: widget.customer.url,
                  name: _nameController.text,
                  email: _emailController.text,
                  phone: _phoneController.text,
                  address: _addressController.text,
                  city: _cityController.text,
                  pincode: _pincodeController.text,
                  gstNo: _gstController.text,
                );
                Navigator.pop(context, editedCustomer);
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
} 