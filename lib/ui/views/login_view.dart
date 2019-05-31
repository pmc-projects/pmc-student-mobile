import 'package:flutter/material.dart';
import 'package:pmc_student/core/viewmodels/login_model.dart';
import 'package:pmc_student/core/viewmodels/viewstate.dart';
import 'package:pmc_student/ui/views/base_view.dart';
import 'package:pmc_student/ui/widgets/login_form.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
        builder: (context, model, child) => Scaffold(
              body: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Container(height: 40.0),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 100.0,
                      child: Image.asset("assets/pmc-student-logo.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: LoginForm(
                        validationMessage: model.errorMessage,
                        isLoading: model.state == ViewState.BUSY,
                        onLogin: (String email, String password) async {
                          var isSuccess = await model.signIn(email, password);
                          if (isSuccess) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (_) => false);
                          }
                        },
                        onSignup: (String email, String password) async {
                          var isSuccess = await model.signUp(email, password);
                          if (isSuccess) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (_) => false);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
