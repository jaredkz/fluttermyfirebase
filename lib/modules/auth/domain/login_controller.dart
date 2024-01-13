import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> login(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      Modular.to.navigate('/home/'); // Navigate to Home on success.
    } on FirebaseAuthException catch (e) {
      // Convert FirebaseAuthException to a more user-friendly message.
      throw Exception(_parseFirebaseAuthException(e));
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
