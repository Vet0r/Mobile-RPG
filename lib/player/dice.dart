import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

diceForTable(String campID, String fieldFB, String field, BuildContext context,
    DocumentSnapshot<Map<String, dynamic>>? documents) {
  int value;
  var controller = TextEditingController();
  var update = FirebaseFirestore.instance
      .collection('campaigns')
      .doc(campID)
      .collection("players")
      .doc(documents?.id);
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      suffixIcon: IconButton(
        onPressed: () {
          update.update(
            {
              "dice": Random().nextInt(int.parse(controller.text)),
              "roled_dice": int.parse(controller.text),
            },
          );
        },
        icon: const Icon(Icons.square_rounded),
      ),
    ),
  );
}
