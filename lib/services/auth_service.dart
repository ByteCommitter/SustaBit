import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Check if user is signed in
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  
  // Get current user
  User? get currentUser => _auth.currentUser;

  // Check if user is a new user
  Future<bool> isNewUser() async {
    return true; // Always treat as a new user to trigger onboarding
  }

  // Sign in with Google - BYPASS VERSION
  Future<UserCredential?> signInWithGoogle() async {
    print('BYPASS: Skipping actual Google Sign In process...');
    try {
      // Check if we already have a user signed in
      if (_auth.currentUser != null) {
        print('BYPASS: User already signed in, signing out first...');
        await _auth.signOut();
      }

      print('BYPASS: Attempting anonymous sign in...');
      
      // Try to sign in anonymously
      final userCredential = await _auth.signInAnonymously();
      print('BYPASS: Created anonymous user with ID: ${userCredential.user?.uid}');
      
      // Save mock user data to Firestore
      if (userCredential.user != null) {
        try {
          await _saveBypassUserToFirestore(userCredential.user!);
          print('BYPASS: Mock user data saved to Firestore');
        } catch (firestoreError) {
          print('BYPASS: Error saving to Firestore, but continuing: $firestoreError');
          // Don't let Firestore errors stop the sign-in process
        }
      }
      
      return userCredential;
    } catch (e) {
      print('Error in bypass sign in: $e');
      print('Error stack trace: ${StackTrace.current}');
      
      // Try a more direct approach if anonymous auth fails
      try {
        print('BYPASS: Attempting alternative sign-in approach...');
        // Create a fake email and password
        String fakeEmail = 'bypass_${DateTime.now().millisecondsSinceEpoch}@example.com';
        String fakePassword = 'BypassPassword123!';
        
        // Create a new user in Firebase
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: fakeEmail,
          password: fakePassword
        );
        
        print('BYPASS: Created email user with ID: ${userCredential.user?.uid}');
        
        // Save user data
        if (userCredential.user != null) {
          try {
            await _saveBypassUserToFirestore(userCredential.user!);
          } catch (firestoreError) {
            print('BYPASS: Error saving to Firestore, but continuing: $firestoreError');
          }
        }
        
        return userCredential;
      } catch (fallbackError) {
        print('BYPASS: Alternative sign-in also failed: $fallbackError');
        return null;
      }
    }
  }

  // Save bypass user to Firestore with mock data
  Future<void> _saveBypassUserToFirestore(User user) async {
    // Create a timestamp for a unique display name
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    
    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': 'test_user_$timestamp@example.com',
      'displayName': 'Test User $timestamp',
      'photoURL': null,
      'createdAt': FieldValue.serverTimestamp(),
      'hasCompletedOnboarding': false,
    });
  }

  // Save user to Firestore
  Future<void> _saveUserToFirestore(User user) async {
    await _firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'displayName': user.displayName,
      'photoURL': user.photoURL,
      'createdAt': FieldValue.serverTimestamp(),
      'hasCompletedOnboarding': false,
    });
  }

  // Update onboarding status
  Future<void> completeOnboarding() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'hasCompletedOnboarding': true,
      });
    }
  }

  // Check if user has completed onboarding
  Future<bool> hasCompletedOnboarding() async {
    final user = _auth.currentUser;
    if (user == null) return false;
    
    try {
      var userDoc = await _firestore.collection('users').doc(user.uid).get();
      return userDoc.data()?['hasCompletedOnboarding'] ?? false;
    } catch (e) {
      print('Error checking onboarding status: $e');
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
