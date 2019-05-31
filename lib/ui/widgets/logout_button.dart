import 'package:flutter/material.dart';
import 'package:pmc_student/core/viewmodels/login_model.dart';
import 'package:pmc_student/ui/views/base_view.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, model, child) => SizedBox(
            height: 30.0,
            child: FlatButton(
              child: Text("Izloguj se"),
              textColor: Colors.deepPurple,
              onPressed: () async {
                await model.signOut();

                Navigator.pushNamedAndRemoveUntil(
                    context, 'login', (_) => false);
              },
            ),
          ),
    );
  }
}
