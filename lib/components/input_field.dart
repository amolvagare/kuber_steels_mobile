import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController? controller;
  final bool isPassword;
  final bool isRequired;
  final String? errorMessage;
  final String? Function(String?)? validator;

  const CustomInputField({super.key, 
    required this.label,
    required this.icon,
    this.controller,
    this.validator,
    this.errorMessage,
    this.isPassword = false,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.subtleText),
        hintText: label, // Use hintText instead of labelText
        hintStyle: const TextStyle(color: AppColors.subtleText),
        filled: true,
        fillColor: AppColors.fieldBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: AppColors.textColor),
      validator: validator ?? (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return errorMessage ?? 'Please enter value';
        }
        // Add more email validation if needed
        return null;
      },
    );
  }
}
