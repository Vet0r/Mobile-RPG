import 'package:flutter/material.dart';

searchingWidget(String content) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          content,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: CircularProgressIndicator(),
        ),
      ],
    ),
  );
}
