import 'package:flutter/material.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';

standardTextFieldDecoration(String field, int appColor) {
  return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: CustomTheme.buttons[appColor]),
      ),
      fillColor: CustomTheme.white[appColor],
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: 3, color: CustomTheme.buttons70[appColor]),
      ),
      labelText: field,
      labelStyle: TextStyle(color: CustomTheme.white[appColor]));
}
