import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<String> createNewPlayer(String name, String campaingDocId) async {
  CollectionReference players = FirebaseFirestore.instance
      .collection('/campaigns')
      .doc(campaingDocId)
      .collection('players');

  Map<String, dynamic> mapPlayer = <String, dynamic>{
    "user_id": FirebaseAuth.instance.currentUser!.uid,
    "name": name,
    "hp": 15,
    "hp_temp": 0,
    "hp_total": 15,
    "armor": 0,
    "iniciative": 0,
    "deslocamento": 0,
    "xp": 0,
    "dice": 0,
    "level": 0,
    "roled_dice": 0,
    "race": "",
    "class": "",
    "force": 0,
    "dex": 0,
    "constitution": 0,
    "inteligence": 0,
    "knologe": 0,
    "charisma": 0,
    "forceMd": 0,
    "dexMd": 0,
    "constitutionMd": 0,
    "inteligenceMd": 0,
    "knologeMd": 0,
    "charismaMd": 0,
  };

  DocumentReference playerId = await players.add(mapPlayer);
  return playerId.id;
}
