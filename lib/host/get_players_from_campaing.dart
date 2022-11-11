import 'package:cloud_firestore/cloud_firestore.dart';

getPlayersFromCamapaing(String campaingId) async {
  var allCampaigns =
      await FirebaseFirestore.instance.collection('/campaigns').get();
  var allPlayers = FirebaseFirestore.instance.collection('players').snapshots();

  for (var doc in allCampaigns.docs) {
    var players = await FirebaseFirestore.instance
        .collection('/players')
        .doc(doc.id)
        .get();
    if (players["campaing_code"] == campaingId) {
      break;
    }
  }
}
