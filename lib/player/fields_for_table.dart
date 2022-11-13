import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

fieldsFortable(String fieldFB, String field, BuildContext context,
    DocumentSnapshot<Map<String, dynamic>>? documents,
    {MaterialColor? fieldColor}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: fieldColor ?? Colors.brown,
              child: Text(
                "$field: ${documents?.get(fieldFB)}",
                style: const TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
        const Divider(
          height: 0.1,
          thickness: 2,
        ),
      ],
    ),
  );
}
