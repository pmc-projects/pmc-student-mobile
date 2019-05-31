import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pmc_student/core/services/authentication_service.dart';

class FirebaseUserMock extends Mock implements FirebaseUser {
  String get uid => 'john';

  String get displayName => 'John Doe';

  String get email => 'john@example.com';
}

class FirebaseAuthMock extends Mock implements FirebaseAuth {
  FirebaseUser user;

  Future<FirebaseUser> signInWithEmailAndPassword(
      {String email, String password}) {
    user = FirebaseUserMock();

    return Future.value(user);
  }

  Future<FirebaseUser> currentUser() async {
    return Future.value(user);
  }
}

void main() {
  group('FirebaseAuthService', () {
    final firebaseAuthMock = FirebaseAuthMock();

    final authService = FirebaseAuthenticationService(firebaseAuthMock);

    test('getCurrentUser returns null when not logged in', () async {
      final user = await authService.getCurrentUser();

      expect(user, null);
    });

    test('signIn', () async {
      await authService.signIn('john@example.com', 'password');

      final user = await authService.getCurrentUser();

      expect(user.email, 'john@example.com');
    });
  });
}
