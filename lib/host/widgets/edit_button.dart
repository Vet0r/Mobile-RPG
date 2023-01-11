import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../styles/custom_theme.dart';

editButton(
    bool isNumber,
    String campaignId,
    String fieldFB,
    DocumentSnapshot<Map<String, dynamic>>? documents,
    BuildContext context,
    int appColor) {
  var controller = TextEditingController();
  return SizedBox(
    height: 20,
    width: 20,
    child: IconButton(
      iconSize: 20,
      padding: const EdgeInsets.all(0),
      onPressed: () async {
        var update = FirebaseFirestore.instance
            .collection("campaigns")
            .doc(campaignId)
            .collection('players')
            .doc(documents?.id);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: '${documents?.get(fieldFB)}',
                  suffixIcon: IconButton(
                    onPressed: () {
                      update.update(
                        {
                          fieldFB: isNumber
                              ? int.parse(controller.text)
                              : controller.text
                        },
                      );
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_forward_rounded,
                      color: CustomTheme.text[appColor],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      icon: Icon(Icons.mode, color: CustomTheme.text[appColor]),
    ),
  );
}
