import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import 'onboarding_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or app name
              const Text(
                "R N T",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 40),
              
              // Welcome text
              const Text(
                "How they Vibes Bussing?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              const Text(
                "Sign in to access your dashboard and resources",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              
              // Google Sign In Button (Dummy button)
              ElevatedButton(
                onPressed: () => Get.off(() => OnboardingScreen()),
                //onPressed: () => _dummySignIn(),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Google logo icon
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Continue with Google',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Development shortcut button
              // ElevatedButton(
              //   onPressed: () => Get.off(() => OnboardingScreen()),
              //   style: ElevatedButton.styleFrom(
              //     foregroundColor: Colors.white,
              //     backgroundColor: Colors.deepPurple,
              //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              //   ),
              //   child: const Text('Skip to Onboarding'),
              // ),
              
              const SizedBox(height: 20),
              
              // Terms and privacy text
              const Text(
                "By continuing, you agree to our Terms of Service and Privacy Policy",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

//   // Simplified dummy sign-in function
//   void _dummySignIn() {
//     // Show loading indicator
//     Get.dialog(
//       const Center(
//         child: CircularProgressIndicator(),
//       ),
//       barrierDismissible: false,
//     );
    
//     // Simulate network delay
//     Future.delayed(const Duration(seconds: 2), () {
//       // Close the loading dialog
//       Get.back();
      
//       // Navigate to onboarding screen
//       Get.off(() => OnboardingScreen());
//     });
//   }

}
