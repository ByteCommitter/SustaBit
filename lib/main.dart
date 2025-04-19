import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mentalsustainability/pages/base_widget.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'pages/auth_wrapper.dart';
import 'pages/onboarding_screen.dart';
import 'pages/Home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Add error handling for Firebase initialization
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
    // We still continue with the app, but some features might not work
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'R N T',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BaseScreen(), // Changed from AuthWrapper() to BaseScreen() for testing
      // Add routes for direct navigation
      getPages: [
        GetPage(name: '/', page: () => AuthWrapper()),
        GetPage(name: '/onboarding', page: () => OnboardingScreen()),
        GetPage(name: '/home', page: () => BaseScreen()),
      ],
    );
  }
}