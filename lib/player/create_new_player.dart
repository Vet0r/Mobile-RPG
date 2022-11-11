import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> createNewPlayer(String name) async {
  CollectionReference players =
      FirebaseFirestore.instance.collection('/players');

  Map<String, dynamic> mapPlayer = <String, dynamic>{
    "name": name,
    "hp": 15,
    "mana": 10,
    "stamina": 10,
    "xp": 0,
    "dice": 0,
  };

  DocumentReference playerId = await players.add(mapPlayer);
  return playerId.id;
}
