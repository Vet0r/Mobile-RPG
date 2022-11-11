import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

fielsFortable(String fieldFB, String field, BuildContext context,
    DocumentSnapshot<Map<String, dynamic>>? documents) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "$field: ${documents?.get(fieldFB)}",
          style: const TextStyle(fontSize: 25),
        ),
      ],
    ),
  );
}
