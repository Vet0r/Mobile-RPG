import 'package:flutter/material.dart';

standardTextFieldDecoration(String field) {
  return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: Colors.brown),
      ),
      fillColor: Colors.black,
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: Colors.brown),
      ),
      labelText: field,
      labelStyle: const TextStyle(color: Colors.brown));
}
