// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile_rpg/player/create_new_player.dart';
import 'package:mobile_rpg/player/player.dart';

class ChoseYourName extends StatefulWidget {
  const ChoseYourName({super.key});

  @override
  State<ChoseYourName> createState() => _ChoseYourNameState();
}

class _ChoseYourNameState extends State<ChoseYourName> {
  bool isLoading = false;
  String? playerId = "";
  String campingDocId = "";
  var nameController = TextEditingController();
  var campaingIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Escolha o seu nome"),
              TextField(
                controller: nameController,
              ),
              const Text("Digite o Id da campanha"),
              TextField(
                controller: campaingIdController,
              ),
              isLoading == true
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (nameController.text == "") {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  content: Text("Digite um nome válido"),
                );
              },
            );
          } else if (campaingIdController.text == "") {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  content: Text("Digite um ID válido"),
                );
              },
            );
          } else if (campaingIdController.text != "") {
            isLoading = true;
            bool verify = false;
            var docs =
                await FirebaseFirestore.instance.collection('/campaigns').get();
            for (var doc in docs.docs) {
              var fields = await FirebaseFirestore.instance
                  .collection('/campaigns')
                  .doc(doc.id)
                  .get();
              if (fields["campaign_code"] == campaingIdController.text) {
                verify = true;
                isLoading = false;
                campingDocId = doc.id;
                break;
              }
            }
            if (verify == true) {
              var playerId =
                  await createNewPlayer(nameController.text, campingDocId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Player(
                    playerId: playerId,
                    campaignId: campingDocId,
                  ),
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    content: Text("Digite um ID válido"),
                  );
                },
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
