import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> createNewPlayer(String name, String campaingDocId) async {
  CollectionReference players = FirebaseFirestore.instance
      .collection('/campaigns')
      .doc(campaingDocId)
      .collection('players');

  Map<String, dynamic> mapPlayer = <String, dynamic>{
    "name": name,
    "hp": 15,
    "mana": 10,
    "stamina": 10,
    "xp": 0,
    "dice": 0,
    "level": 0,
    "roled_dice": 0,
  };

  DocumentReference playerId = await players.add(mapPlayer);
  return playerId.id;
}
