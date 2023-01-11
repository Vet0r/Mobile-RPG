import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../styles/custom_theme.dart';

retangularFieldsFortable(String fieldFB, String field, BuildContext context,
    DocumentSnapshot<Map<String, dynamic>>? documents, bool isPv,
    {MaterialColor? fieldColor}) {
  return Padding(
    padding: const EdgeInsets.only(left: 5.0, right: 5, bottom: 7, top: 7),
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.12,
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
      child: Column(
        children: [
          Text(
            field,
            style: const TextStyle(fontSize: 25),
          ),
          Text(
            "${documents?.get(fieldFB)}",
            style: const TextStyle(fontSize: 25),
          ),
          isPv
              ? Text(
                  "PV Total: ${documents?.get("$fieldFB" "_total")}",
                  style: const TextStyle(fontSize: 15),
                )
              : Container(),
        ],
      ),
    ),
  );
}
