import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';

playerAppBar(
    String? campaignId, String? playerId, BuildContext context, int appColor) {
  return AppBar(
    backgroundColor: CustomTheme.buttons70[appColor],
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
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              snapshot.data!["name"],
              style: TextStyle(color: CustomTheme.text[appColor]),
            ),
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('campaigns')
                    .doc(campaignId)
                    .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return Text(
                    "Aventura: ${snapshot.data!["campaign_code"]}",
                    style: TextStyle(color: CustomTheme.text[appColor]),
                  );
                }),
          ],
        );
      },
    ),
  );
}
