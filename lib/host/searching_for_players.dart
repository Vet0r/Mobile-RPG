import 'package:flutter/material.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';

searchingWidget(String content, BuildContext context, int appColor) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          content,
          style: TextStyle(
              color: CustomTheme.text[appColor],
              fontSize: MediaQuery.of(context).size.width * 0.06),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: CircularProgressIndicator(
            color: CustomTheme.buttons[appColor],
          ),
        ),
      ],
    ),
  );
}
