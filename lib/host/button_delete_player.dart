import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

buttonDelete(BuildContext context, bool isDelete,
    QueryDocumentSnapshot<Map<String, dynamic>> doc) {
  return TextButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.brown),
    ),
    onPressed: () {
      isDelete
          ? {
              FirebaseFirestore.instance
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
