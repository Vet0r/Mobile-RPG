// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';
import 'package:mobile_rpg/styles/strings.dart';

import '../standard_textfiel_decoration.dart';
import 'host.dart';

class CreatCampaing extends StatefulWidget {
  const CreatCampaing({super.key});

  @override
  State<CreatCampaing> createState() => _CreatCampaingState();
}

class _CreatCampaingState extends State<CreatCampaing> {
  bool verify = false;
  String fbIdcamp = "";
  String campMasterId = "";
  String masterId = FirebaseAuth.instance.currentUser!.uid;
  var idCampaingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTeheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            style: TextStyle(color: CustomTeheme.text),
            cursorColor: CustomTeheme.text,
            decoration:
                standardTextFieldDecoration(StringsAppContent.iddacampanha),
            controller: idCampaingController,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomTeheme.buttons70,
        onPressed: () async {
          if (idCampaingController.text == "") {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  content: Text("Digite um ID válido"),
                );
              },
            );
          } else {
            var docs =
                await FirebaseFirestore.instance.collection('/campaigns').get();
            for (var doc in docs.docs) {
              var fields = await FirebaseFirestore.instance
                  .collection('/campaigns')
                  .doc(doc.id)
                  .get();
              if (fields["campaign_code"] == idCampaingController.text) {
                verify = true;
                campMasterId = fields["master_id"];
                fbIdcamp = doc.id;
                break;
              }
            }
            if (verify == true) {
              if (masterId == campMasterId) {
                verify = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Host(
                      campaingId: fbIdcamp,
                    ),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: CustomTeheme.errorCard,
                      content: Text("Você não é o dono dessa campanha"),
                    );
                  },
                );
              }
            } else {
              fbIdcamp = await createNewCampaing(idCampaingController.text);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Host(
                    campaingId: fbIdcamp,
                  ),
                ),
              );
            }
          }
        },
        tooltip: 'Próximo',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

Future<String> createNewCampaing(String campaingId) async {
  CollectionReference campaigns =
      FirebaseFirestore.instance.collection('/campaigns');

  Map<String, dynamic> mapCampaing = <String, dynamic>{
    "theme_is_playng": false,
    "campaign_code": campaingId,
    "master_id": FirebaseAuth.instance.currentUser!.uid,
    "theme_song":
        "https://cdn.pixabay.com/download/audio/2021/09/06/audio_cb1c3e82d9.mp3?filename=nightmare-on-imaginationland-8040.mp3",
  };

  DocumentReference playerId = await campaigns.add(mapCampaing);
  return playerId.id;
}
