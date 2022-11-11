import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

playerAppBar(String? campaignId, String? playerId, BuildContext context) {
  return AppBar(
    backgroundColor: Colors.brown,
    centerTitle: true,
    automaticallyImplyLeading: false,
    title: FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('campaigns')
          .doc(campaignId)
          .collection("players")
          .doc(playerId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Text(
          snapshot.data!["name"],
        );
      },
    ),
  );
}
