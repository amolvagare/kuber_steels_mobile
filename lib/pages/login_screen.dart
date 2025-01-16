import 'package:flutter/material.dart';
import 'package:kuber_steels/services/authentication.dart';
import '../components/button.dart';
import '../components/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Light background color
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Centered content
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Welcome Text
                      const Text(
                        'Welcome to Kuber Steel Industries',
                        style: TextStyle(
                          color: Colors.black,
                          // Dark color for visibility on light background
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      Form(
                          key: _formKey,
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  // Username Input Field
                                  CustomInputField(
                                    label: 'Username',
                                    icon: Icons.person,
                                    controller: _emailController,
                                    isRequired: true,
                                    errorMessage: "please enter username",
                                  ),
                                  const SizedBox(height: 16),

                                  // Password Input Field
                                  CustomInputField(
                                    label: 'Password',
                                    icon: Icons.lock,
                                    isPassword: true,
                                    isRequired: true,
                                    controller: _passwordController,
                                    errorMessage: "please enter password",
                                  ),
                                  const SizedBox(height: 16),

                                  // Forgot Password Link
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/forgot-password');
                                      },
                                      child: const Text(
                                        'Forgot password?',
                                        style: TextStyle(
                                            color: Colors
                                                .blueAccent), // Accent color for visibility
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  // Login Button
                                  CustomButton(
                                    text: 'LOGIN',
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        print(_emailController.text.trim());
                                        print(_passwordController.text.trim());
                                        new AuthenticationService()
                                            .signInWithEmailAndPassword(
                                                _emailController.text.trim(),
                                                _passwordController.text
                                                    .trim());
                                      }
                                    },
                                  ),
                                ],
                              )))
                    ],
                  ),
                ),
              ),
            ),

            // Footer Text at the bottom of the screen
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                children: [
                  Text(
                    'Powered by Polynovators',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'info@polynovators.com',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
