// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../standard_textfiel_decoration.dart';

WeaponsAndArmorsTextField(
  String weapon1,
  String weapon2,
  String weapon3,
  String armor1,
  String armor2,
  String field,
  BuildContext context,
  String playerId,
  String campainId,
  DocumentSnapshot<Map<String, dynamic>>? documents,
) {
  return Padding(
    padding: const EdgeInsets.only(left: 5.0, right: 5, bottom: 7, top: 7),
    child: Container(
      width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height * 0.12,
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
            style: const TextStyle(fontSize: 25),
          ),
          weaponsField(context, weapon1, weapon2, weapon3, armor1, armor2,
              playerId, campainId, documents),
        ],
      ),
    ),
  );
}

weaponsField(
  BuildContext context,
  String weapon1,
  String weapon2,
  String weapon3,
  String armor1,
  String armor2,
  String playerId,
  String campainId,
  DocumentSnapshot<Map<String, dynamic>>? documents,
) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Column(
      children: [
        Text(
          "Armas",
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.07),
        ),
        weapons(context, weapon1, campainId, playerId, documents),
        weapons(context, weapon2, campainId, playerId, documents),
        weapons(context, weapon3, campainId, playerId, documents),
        Divider(),
        Text(
          "Armadura",
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.07),
        ),
        armor(context, armor1, campainId, playerId, documents),
        armor(context, armor2, campainId, playerId, documents),
      ],
    ),
  );
}

writeOnFieldFB(String campainId, String playerId, Map<String, dynamic>? field) {
  FirebaseFirestore.instance
      .collection('campaigns')
      .doc(campainId)
      .collection('players')
      .doc(playerId)
      .update(field!);
}

armor(BuildContext context, String armor, String campainId, String playerId,
    DocumentSnapshot<Map<String, dynamic>>? documents) {
  String index = armor.substring(armor.length - 1, armor.length);
  Map<String, dynamic> field = documents!["armor$index"];
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.09,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nome"),
              TextField(
                decoration: InputDecoration(
                  hintText: field["name$index"],
                ),
                onChanged: (value) {
                  field = {
                    "damageRed$index": field["damageRed$index"],
                    "name$index": value,
                    "weight$index": field["weight$index"],
                  };
                  Map<String, dynamic> fielMap = {
                    "armor$index": field,
                  };
                  writeOnFieldFB(campainId, playerId, fielMap);
                },
              ),
            ],
          ),
        ),
        VerticalDivider(
          thickness: 1.0,
          width: MediaQuery.of(context).size.width * 0.01,
          color: Colors.black,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Peso"),
              TextField(
                decoration: InputDecoration(
                  hintText: field["weight$index"],
                ),
                onChanged: (value) {
                  field = {
                    "damageRed$index": field["damageRed$index"],
                    "name$index": field["name$index"],
                    "weight$index": value,
                  };
                  Map<String, dynamic> fielMap = {
                    "armor$index": field,
                  };
                  writeOnFieldFB(campainId, playerId, fielMap);
                },
              ),
            ],
          ),
        ),
        VerticalDivider(
          thickness: 1.0,
          width: MediaQuery.of(context).size.width * 0.01,
          color: Colors.black,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("DMG RED"),
              TextField(
                decoration: InputDecoration(
                  hintText: field["damageRed$index"],
                ),
                onChanged: (value) {
                  field = {
                    "damageRed$index": value,
                    "name$index": field["name$index"],
                    "weight$index": field["weight$index"],
                  };
                  Map<String, dynamic> fielMap = {
                    "armor$index": field,
                  };
                  writeOnFieldFB(campainId, playerId, fielMap);
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

weapons(BuildContext context, String weapons, String campainId, String playerId,
    DocumentSnapshot<Map<String, dynamic>>? documents) {
  String index = weapons.substring(weapons.length - 1, weapons.length);
  Map<String, dynamic> field = documents!["weapon$index"];
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.09,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nome"),
              TextField(
                decoration: InputDecoration(
                  hintText: field["name$index"],
                ),
                onChanged: (value) {
                  field = {
                    "damage$index": field["damage$index"],
                    "name$index": value,
                    "weight$index": field["weight$index"],
                  };
                  Map<String, dynamic> fielMap = {
                    "weapon$index": field,
                  };
                  writeOnFieldFB(campainId, playerId, fielMap);
                },
              ),
            ],
          ),
        ),
        VerticalDivider(
          thickness: 1.0,
          width: MediaQuery.of(context).size.width * 0.01,
          color: Colors.black,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Peso"),
              TextField(
                decoration: InputDecoration(
                  hintText: field["weight$index"],
                ),
                onChanged: (value) {
                  field = {
                    "damage$index": field["damage$index"],
                    "name$index": field["name$index"],
                    "weight$index": value,
                  };
                  Map<String, dynamic> fielMap = {
                    "weapon$index": field,
                  };
                  writeOnFieldFB(campainId, playerId, fielMap);
                },
              ),
            ],
          ),
        ),
        VerticalDivider(
          thickness: 1.0,
          width: MediaQuery.of(context).size.width * 0.01,
          color: Colors.black,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Dano"),
              TextField(
                decoration: InputDecoration(
                  hintText: field["damage$index"],
                ),
                onChanged: (value) {
                  field = {
                    "damage$index": value,
                    "name$index": field["name$index"],
                    "weight$index": field["weight$index"],
                  };
                  Map<String, dynamic> fielMap = {
                    "weapon$index": field,
                  };
                  writeOnFieldFB(campainId, playerId, fielMap);
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
