import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'base_widget.dart';
import '../services/onboarding_screen.dart';
import 'package:get/get.dart';

class AuthWrapper extends StatelessWidget {
  final AuthService _authService = AuthService();
  
  AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // For development purposes, show a simple login screen and then navigate to onboarding
    Future.delayed(Duration(seconds: 2), () {
      Get.offAll(() => const OnboardingScreen());
    });
    
    // Simple login screen placeholder
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Sereine Logo with Brain and Leaf.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(),
            const SizedBox(height: 30),
            const Text(
              'Signing in...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54
              ),
            )
          ],
        ),
      ),
    );
    
    // When you need to implement actual auth, use this:
    /*
    return StreamBuilder<User?>(
      stream: _authService.userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return LoginScreen(); // A login screen
          } else {
            return const OnboardingScreen(); // Go to onboarding first
          }
        }
        
        // While waiting for connection, show loading
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
    */
  }
}
