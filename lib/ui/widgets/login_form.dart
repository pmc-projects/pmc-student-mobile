import 'package:flutter/material.dart';
import 'package:pmc_student/ui/shared/text_styles.dart';
import 'package:pmc_student/ui/shared/ui_helpers.dart';

enum FormMode { LOGIN, SIGNUP }

class LoginForm extends StatefulWidget {
  final String validationMessage;

  final bool isLoading;

  final Function(String email, String password) onLogin;
  final Function(String email, String password) onSignup;

  LoginForm(
      {Key key,
      this.validationMessage,
      this.isLoading,
      this.onLogin,
      this.onSignup})
      : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FormMode _formMode = FormMode.LOGIN;

  void _toggleFormMode() {
    setState(() {
      _formMode =
          _formMode == FormMode.SIGNUP ? FormMode.LOGIN : FormMode.SIGNUP;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_formMode == FormMode.LOGIN ? 'Prijava' : 'Registracija',
              style: headerStyle),
          UIHelper.verticalSpaceSmall(),
          Text(
              _formMode == FormMode.LOGIN
                  ? 'Unesite Vašu email adresu i šifru'
                  : 'Unesite željenu email adresu i šifru',
              style: subHeaderStyle),
          UIHelper.verticalSpaceSmall(),
          LoginTextField(_emailController, "Email adresa", false),
          UIHelper.verticalSpaceSmall(),
          LoginTextField(_passwordController, "Šifra", true),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: this.widget.validationMessage != null
                ? Text(widget.validationMessage,
                    style: TextStyle(color: Colors.red))
                : Container(),
          ),
          _buildActionButton(),
          _buildSecondaryButton(),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return MaterialButton(
      color: Colors.deepPurple,
      minWidth: double.infinity,
      child: widget.isLoading
          ? SizedBox(
              height: 15.0,
              width: 15.0,
              child: Theme(
                data: Theme.of(context).copyWith(accentColor: Colors.white),
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                ),
              ),
            )
          : Text(
              _formMode == FormMode.LOGIN ? "Prijavite se" : "Registrujte se",
              style: TextStyle(color: Colors.white),
            ),
      onPressed: () {
        switch (_formMode) {
          case FormMode.LOGIN:
            if (widget.onLogin != null) {
              widget.onLogin(_emailController.text, _passwordController.text);
            }
            break;
          case FormMode.SIGNUP:
            if (widget.onSignup != null) {
              widget.onSignup(_emailController.text, _passwordController.text);
            }
        }
      },
    );
  }

  Widget _buildSecondaryButton() {
    return SizedBox(
      height: 30.0,
      child: MaterialButton(
        minWidth: double.infinity,
        child: Text(
          _formMode == FormMode.LOGIN
              ? "Nemate nalog? Registrujte se."
              : "Imate nalot? Ulogujte se.",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onPressed: _toggleFormMode,
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;

  final String label;
  final bool isHidden;

  LoginTextField(this.controller, this.label, this.isHidden);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration.collapsed(hintText: label),
          obscureText: isHidden,
          keyboardType:
              isHidden ? TextInputType.text : TextInputType.emailAddress,
          controller: controller,
        ),
      ),
    );
  }
}
