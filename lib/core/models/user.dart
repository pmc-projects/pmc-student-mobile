import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String id;
  final String name;
  final String email;

  User(this.id, this.name, this.email);

  factory User.fromFirebase(FirebaseUser user) {
    return User(user.uid, user.displayName, user.email);
  }
}
