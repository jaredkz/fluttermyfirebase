import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthController extends Disposable {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  StreamSubscription<User?>? authStateSubscription;

  // StreamController for error messages.
  StreamController<String> errorController =
      StreamController<String>.broadcast();

  // Stream for external components to listen to.
  Stream<String> get errorStream => errorController.stream;

  User? get currentUser => firebaseAuth.currentUser;

  AuthController() {
    authStateSubscription = firebaseAuth.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          Modular.to.navigate('/');
        } else {
          Modular.to.navigate('/home/');
        }
      },
      onError: (error) {
        // Broadcast the error.
        errorController.add('Error in auth state stream: $error');
      },
    );
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  void dispose() {
    errorController.close();
  }
}
