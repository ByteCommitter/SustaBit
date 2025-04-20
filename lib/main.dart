import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart'; // Comment out Firebase imports
// import 'firebase_options.dart'; // Comment out Firebase options
import 'package:get/get.dart';
import 'package:mentalsustainability/pages/base_widget.dart';
import 'package:mentalsustainability/pages/guide_page.dart';
import 'package:mentalsustainability/theme/app_colors.dart';
import 'package:mentalsustainability/theme/theme_provider.dart';
import 'pages/auth_wrapper.dart';
import 'pages/onboarding_screen.dart';
import 'pages/Home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize theme provider
  Get.put(ThemeProvider());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeProvider>(
      builder: (themeProvider) => GetMaterialApp(
        title: 'Sereine',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.accent,
            background: AppColors.background,
            error: AppColors.error,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.primary,
            elevation: 0,
          ),
          cardTheme: CardTheme(
            color: AppColors.cardBackground,
          ),
          dividerTheme: DividerTheme.of(context).copyWith(
            color: AppColors.divider,
          ),
        ),
        home: AuthWrapper(),
        getPages: [
          GetPage(name: '/', page: () => AuthWrapper()),
          GetPage(name: '/onboarding', page: () => const OnboardingScreen()),
          GetPage(name: '/home', page: () => const BaseScreen()),
          GetPage(name: '/guide', page: () => const GuidePage()),
        ],
      ),
    );
  }
}