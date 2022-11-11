// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  var idCampaingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            cursorColor: Colors.black,
            decoration: standardTextFieldDecoration("ID da Campanha"),
            controller: idCampaingController,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
                fbIdcamp = doc.id;
                break;
              }
            }
            if (verify == true) {
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
    "campaign_code": campaingId,
  };

  DocumentReference playerId = await campaigns.add(mapCampaing);
  return playerId.id;
}
