// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_rpg/player/create_new_player.dart';
import 'package:mobile_rpg/player/player.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';

import '../../standard_textfiel_decoration.dart';

class ChoseYourName extends StatefulWidget {
  const ChoseYourName({super.key});

  @override
  State<ChoseYourName> createState() => _ChoseYourNameState();
}

class _ChoseYourNameState extends State<ChoseYourName> {
  bool isLoading = false;
  var nameController = TextEditingController();
  var campaingIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTeheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                style: TextStyle(color: CustomTeheme.text),
                decoration: standardTextFieldDecoration("Nome"),
                controller: nameController,
                cursorColor: Colors.white,
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                style: TextStyle(color: CustomTeheme.text),
                decoration: standardTextFieldDecoration("ID da Campanha"),
                controller: campaingIdController,
                cursorColor: Colors.white,
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
        backgroundColor: CustomTeheme.buttons70,
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
            String? playerId = "";
            String campingDocId = "";
            isLoading = true;
            bool verify = false;
            bool verify2 = false;
            bool verify3 = false;
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
            if (verify) {
              isLoading = true;
              var docs = await FirebaseFirestore.instance
                  .collection('/campaigns')
                  .doc(campingDocId)
                  .collection("players")
                  .get();
              for (var doc in docs.docs) {
                var fields = await FirebaseFirestore.instance
                    .collection('campaigns')
                    .doc(campingDocId)
                    .collection("players")
                    .doc(doc.id)
                    .get();
                if (fields.exists) {
                  if (fields["name"] == nameController.text &&
                      fields["user_id"] ==
                          FirebaseAuth.instance.currentUser!.uid) {
                    verify2 = true;
                    verify3 = true;
                    isLoading = false;
                    playerId = doc.id;
                    break;
                  } else if (fields["name"] == nameController.text &&
                      fields["user_id"] !=
                          FirebaseAuth.instance.currentUser!.uid) {
                    verify2 = true;
                    verify3 = false;
                    break;
                  }
                }
              }
              if (verify2 == true && verify3 == true) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Player(
                      playerId: playerId,
                      campaignId: campingDocId,
                    ),
                  ),
                );
              } else if (verify2 == true && verify3 == false) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      content: Text("Esse nome já está em uso nessa campanha"),
                    );
                  },
                );
              } else {
                playerId =
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
              }
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
