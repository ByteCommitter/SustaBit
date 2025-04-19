import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart'; // Comment out Firebase imports
// import 'firebase_options.dart'; // Comment out Firebase options
import 'package:get/get.dart';
import 'package:mentalsustainability/pages/base_widget.dart';
import 'pages/auth_wrapper.dart';
import 'pages/onboarding_screen.dart';
import 'pages/Home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Comment out Firebase initialization since you're not using it
  /*
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  */
  
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