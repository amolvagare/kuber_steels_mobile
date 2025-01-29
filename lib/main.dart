import 'package:flutter/material.dart';
import 'package:kuber_steels/product/product_list.dart';
import 'theme/app_theme.dart';
import 'pages/splash_screen.dart';
import 'pages/login_screen.dart';
import 'pages/forgot_password_screen.dart';
import 'pages/home_screen.dart'; // The Home Page after login
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: getAppTheme(),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(), // HomePage shown after login
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/products': (context) => ProductList(),
      },
    );
  }
}
