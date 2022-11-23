import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

checkUser(User userData) async {
  var allUsers = await FirebaseFirestore.instance.collection('/users').get();
  bool userExists = false;

  for (var doc in allUsers.docs) {
    if (doc.id == userData.uid) {
      userExists = true;
      break;
    }
  }
  if (userExists == false) {
    DocumentReference players =
        FirebaseFirestore.instance.collection('/users').doc(userData.uid);

    Map<String, dynamic> mapPlayer = <String, dynamic>{
      "email": userData.email,
    };
    await players.set(mapPlayer);
  }
}
