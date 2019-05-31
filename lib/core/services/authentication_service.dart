import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pmc_student/core/models/user.dart';

abstract class AuthenticationService {
  Future<User> signIn(String email, String password);

  Future<User> signUp(String email, String password);

  Future<User> getCurrentUser();

  Future<void> signOut();
}

class FirebaseAuthenticationService implements AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthenticationService(this._firebaseAuth);

  Future<User> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return User.fromFirebase(user);
  }

  Future<User> signUp(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return User.fromFirebase(user);
  }

  Future<User> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    if (user == null) {
      return null;
    }

    return User.fromFirebase(user);
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
