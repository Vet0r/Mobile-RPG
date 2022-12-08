import 'package:flutter/material.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';

standardTextFieldDecoration(String field) {
  return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: CustomTeheme.buttons),
      ),
      fillColor: CustomTeheme.text,
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: CustomTeheme.buttons70),
      ),
      labelText: field,
      labelStyle: TextStyle(color: CustomTeheme.text));
}
