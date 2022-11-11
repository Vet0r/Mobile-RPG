import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

fielsFortableMaster(
    String campaignId,
    String fieldFB,
    String field,
    BuildContext context,
    QueryDocumentSnapshot<Map<String, dynamic>> documents) {
  var controller = TextEditingController();
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$field: ${documents.get(fieldFB)}",
          style: const TextStyle(fontSize: 20),
        ),
        fieldFB == "roled_dice" || fieldFB == "dice"
            ? Container()
            : IconButton(
                onPressed: () async {
                  var update = FirebaseFirestore.instance
                      .collection("campaigns")
                      .doc(campaignId)
                      .collection('players')
                      .doc(documents.id);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: '${documents.get(fieldFB)}',
                            suffixIcon: IconButton(
                              onPressed: () {
                                update.update(
                                  {fieldFB: int.parse(controller.text)},
                                );
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_forward_rounded),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.mode),
              ),
      ],
    ),
  );
}
