import 'package:flutter/material.dart';

class UIHelper {
  static Widget verticalSpaceSmall() {
    return verticalSpace(10.0);
  }

  static Widget verticalSpaceMedium() {
    return verticalSpace(20.0);
  }

  static Widget verticalSpaceLarge() {
    return verticalSpace(60.0);
  }

  static Widget verticalSpace(double height) {
    return Container(height: height);
  }
}
