import 'dart:math';

import 'package:flutter/material.dart';

Widget rollMasterDice() {
  var controller = TextEditingController();
  int value = 1;
  return Row(
    children: [
      Text(value.toString()),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              value = Random().nextInt(int.parse(controller.text));
            },
            icon: const Icon(Icons.square_rounded),
          ),
        ),
      ),
    ],
  );
}
