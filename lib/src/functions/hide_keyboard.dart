import 'package:flutter/material.dart';

void hideKeyboard(BuildContext ctx) {
  // Will remove the keyboard
  FocusScopeNode currentFocus = FocusScope.of(ctx);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }
}
