import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterController {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> registerUser(
    String email,
    String password,
    String username,
  ) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await createUserDocument(userCredential, username);
      Modular.to.navigate('/home/'); // Navigate to Home on success.
    } on FirebaseAuthException catch (e) {
      // Use the original exception's message for a user-friendly error.
      final errorMessage = _parseFirebaseAuthException(e);
      print(errorMessage); // Optionally log the error message for debugging.
      rethrow; // Rethrow the original exception.
    }
  }

  Future<void> createUserDocument(
    UserCredential userCredential,
    String username,
  ) async {
    if (userCredential.user != null) {
      await _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'username': username,
      });
    }
  }

  String _parseFirebaseAuthException(FirebaseAuthException e) {
    // Customize error messages based on the exception code.
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';

      case 'wrong-password':
        return 'Wrong password provided.';
      // Add more cases as needed.

      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
