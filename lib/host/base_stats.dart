import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';

baseStats(BuildContext context, double width,
    QueryDocumentSnapshot<Map<String, dynamic>> documents, String field) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        border: Border.all(
          width: 3,
          color: CustomTheme.black.withAlpha(66),
          style: BorderStyle.solid,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(width * 0.01),
        child: Text(
          field,
          style: TextStyle(fontSize: width * 0.06, color: CustomTheme.black),
        ),
      ),
    ),
  );
}
