import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

masterDiceForTable(BuildContext context) {
  int value = 0;
  var controller = TextEditingController();
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      suffixIcon: IconButton(
        onPressed: () {
          value = Random().nextInt(
            int.parse(controller.text),
          );
        },
        icon: Text(value.toString()),
      ),
    ),
  );
}
