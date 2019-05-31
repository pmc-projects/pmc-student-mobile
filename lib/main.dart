import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pmc_student/core/models/user.dart';
import 'package:pmc_student/core/viewmodels/login_model.dart';
import 'package:pmc_student/locator.dart';
import 'package:pmc_student/ui/router.dart';
import 'package:provider/provider.dart';

final firebaseAuth = FirebaseAuth.instance;

void main() async {
  setupLocator();

  final user = await locator<LoginModel>().getCurrentUser();

  runApp(PMCStudentApp(initialUser: user));
}

class PMCStudentApp extends StatelessWidget {
  final User initialUser;

  const PMCStudentApp({Key key, this.initialUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      initialData: initialUser,
      builder: (context) => locator<LoginModel>().userController,
      child: MaterialApp(
        title: "PMC Student",
        theme: ThemeData(
          accentColor: Colors.deepPurple,
          canvasColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        initialRoute: initialUser == null ? 'login' : '/',
        onGenerateRoute: Router.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
