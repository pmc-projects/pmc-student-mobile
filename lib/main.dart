import 'package:flutter/material.dart';

import 'package:pmc_student/services/authentication.dart';
import 'package:pmc_student/pages/login_signup_page.dart';

void main() => runApp(new PMCStudentApp());

class PMCStudentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PMC Student",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginSignUpPage(auth: Auth()),
    );
  }
}
