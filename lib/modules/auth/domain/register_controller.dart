import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser(
      String email, String password, String username) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await createUserDocument(userCredential, username);
      Modular.to.navigate('/home/'); // Navigate to Home on success.
    } on FirebaseAuthException catch (e) {
      throw Exception(_parseFirebaseAuthException(e));
    }
  }

  String _parseFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      // Add more cases as needed.
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  Future<void> createUserDocument(
      UserCredential userCredential, String username) async {
    if (userCredential.user != null) {
      await _firestore.collection('Users').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'username': username,
      });
    }
  }
}
