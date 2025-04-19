import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'base_widget.dart';

class AuthWrapper extends StatelessWidget {
  final AuthService _authService = AuthService();
  
  AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // For development purposes, directly return the main app screen
    return const BaseScreen(); 
    
    // When you need to implement actual auth, use this:
    /*
    return StreamBuilder<User?>(
      stream: _authService.userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return OnboardingScreen();
          } else {
            return const BaseScreen();
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
