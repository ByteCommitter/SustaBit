import 'package:flutter/material.dart';

// Mock AuthService that doesn't use Firebase
class AuthService {
  // Mock sign in methods
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    debugPrint("Mock sign in with email: $email");
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    return;
  }
  
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    debugPrint("Mock create user with email: $email");
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    return;
  }
  
  Future<void> signOut() async {
    debugPrint("Mock sign out successful");
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    return;
  }
  
  // Add any other auth methods your app needs
}
