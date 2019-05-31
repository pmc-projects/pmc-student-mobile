import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pmc_student/core/models/user.dart';
import 'package:pmc_student/core/services/authentication_service.dart';
import 'package:pmc_student/core/viewmodels/base_model.dart';
import 'package:pmc_student/core/viewmodels/viewstate.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService;

  StreamController<User> userController = StreamController<User>();

  String errorMessage;

  LoginModel(this._authenticationService);

  Future<User> getCurrentUser() async {
    setState(ViewState.BUSY);
    final user = await _authenticationService.getCurrentUser();
    if (user != null) {
      userController.add(user);
    }
    setState(ViewState.IDLE);

    return user;
  }

  Future<bool> signIn(String email, String password) async {
    setState(ViewState.BUSY);

    var isSuccess = false;
    try {
      final user = await _authenticationService.signIn(email, password);
      isSuccess = user != null;
      if (isSuccess) {
        userController.add(user);
      }
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_USER_NOT_FOUND') {
        errorMessage = 'Pogrešni kredencijali';
      } else {
        errorMessage = e.toString();
      }
    } on Exception catch (e) {
      errorMessage = e.toString();
    }

    setState(ViewState.IDLE);

    return isSuccess;
  }

  Future<bool> signUp(String email, String password) async {
    setState(ViewState.BUSY);

    var isSuccess = false;
    try {
      final user = await _authenticationService.signUp(email, password);
      isSuccess = user != null;
      if (isSuccess) {
        userController.add(user);
      }
    } on Exception catch (e) {
      errorMessage = e.toString();
    }

    setState(ViewState.IDLE);

    return isSuccess;
  }

  Future<void> signOut() async {
    setState(ViewState.BUSY);

    await _authenticationService.signOut();
    userController.add(null);

    setState(ViewState.IDLE);
  }
}
