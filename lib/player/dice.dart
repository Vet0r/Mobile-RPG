import 'dart:math';

import 'package:flutter/material.dart';

rollDice() {
  var controller = TextEditingController();
  TextField(
    controller: controller,
    decoration: InputDecoration(
      suffixIcon: IconButton(
        onPressed: () {
          // update.update(
          //   {"dice": int.parse(controller.text)},
          // );
        },
        icon: const Icon(Icons.arrow_forward_rounded),
      ),
    ),
  );
  Random().nextInt(int.parse(controller.text));
}
