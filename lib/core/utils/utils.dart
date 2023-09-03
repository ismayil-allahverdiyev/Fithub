import 'package:flutter/material.dart';

class DeviceUtils {
  static unFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
