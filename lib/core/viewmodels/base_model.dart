import 'package:flutter/material.dart';
import 'package:pmc_student/core/viewmodels/viewstate.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.IDLE;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
