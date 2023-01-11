import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';

buttonDelete(String? campaingId, BuildContext context, bool isDelete,
    DocumentSnapshot<Map<String, dynamic>> doc, int appColor) {
  return TextButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(isDelete
          ? CustomTheme.errorCard[appColor]
          : CustomTheme.buttons[appColor]),
    ),
    onPressed: () {
      isDelete
          ? {
              FirebaseFirestore.instance
                  .collection("campaigns")
                  .doc(campaingId)
                  .collection("players")
                  .doc(doc.id)
                  .delete(),
              Navigator.pop(context),
              Navigator.pop(context),
            }
          : Navigator.pop(context);
    },
    child: Text(
      style: TextStyle(color: CustomTheme.black),
      isDelete ? "Sim" : "Não",
    ),
  );
}
