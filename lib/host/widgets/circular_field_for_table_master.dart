import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'edit_button.dart';

circularFieldsFortableMaster(
    bool isNumber,
    campaignId,
    String fieldFB,
    String field,
    BuildContext context,
    DocumentSnapshot<Map<String, dynamic>>? documents,
    {MaterialColor? fieldColor}) {
  return Padding(
    padding: const EdgeInsets.only(left: 5.0, right: 5, bottom: 7, top: 7),
    child: Container(
      width: MediaQuery.of(context).size.width * 0.40,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        border: Border.all(
          width: 3,
          color: Colors.black26,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Text(
            field,
            style: const TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${documents?.get(fieldFB)}",
                style: const TextStyle(fontSize: 25),
              ),
              editButton(isNumber, campaignId, fieldFB, documents, context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${documents?.get("${fieldFB}Md")}",
                style: const TextStyle(fontSize: 15),
              ),
              editButton(
                  isNumber, campaignId, "${fieldFB}Md", documents, context),
            ],
          ),
        ],
      ),
    ),
  );
}
