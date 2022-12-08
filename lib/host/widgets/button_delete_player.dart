import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';

buttonDelete(String? campaingId, BuildContext context, bool isDelete,
    DocumentSnapshot<Map<String, dynamic>> doc) {
  return TextButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
          isDelete ? CustomTeheme.errorCard : CustomTeheme.buttons),
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
            }
          : Navigator.pop(context);
    },
    child: Text(
      style: const TextStyle(color: Colors.black),
      isDelete ? "Sim" : "Não",
    ),
  );
}
