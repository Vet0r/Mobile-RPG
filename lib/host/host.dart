// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators

import 'dart:math';

import 'package:audio_manager/audio_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_rpg/host/searching_for_players.dart';
import 'package:mobile_rpg/host/sow_player_table.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';

import '../standard_textfiel_decoration.dart';
import 'base_stats.dart';

class Host extends StatefulWidget {
  String? campaingId;
  Host({this.campaingId, super.key});

  @override
  State<Host> createState() => _HostState();
}

class _HostState extends State<Host> {
  int value = 0;
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('campaigns')
              .doc(widget.campaingId)
              .get(),
          builder: (context, snapshot) {
            return Center(
              child: Text(
                snapshot.data!["campaign_code"],
              ),
            );
          },
        ),
        backgroundColor: CustomTeheme.buttons70,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: CustomTeheme.buttons70,
                    content: SizedBox(
                      height: height * 0.20,
                      child: Column(
                        children: [
                          TextField(
                            style: TextStyle(color: CustomTeheme.text),
                            decoration: standardTextFieldDecoration("mp3 Link"),
                            controller: controller,
                            cursorColor: Colors.white,
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  controller.text = controller.text;
                                });
                                AudioManager.instance
                                    .start(
                                  controller.text,
                                  "Mobile RPG",
                                  desc: "Mobile RPG Sound",
                                  cover:
                                      "assets/pngfind.com-formatura-png-2075195.png",
                                )
                                    .then(
                                  (err) {
                                    print("ERRO AQUI $err -------------------");
                                  },
                                );
                                Map<String, dynamic> themeMap =
                                    <String, dynamic>{
                                  "theme_time":
                                      AudioManager.instance.position.toString(),
                                  "theme_song": controller.text,
                                  "theme_is_playng":
                                      !AudioManager.instance.isPlaying,
                                };
                                FirebaseFirestore.instance
                                    .collection('campaigns')
                                    .doc(widget.campaingId)
                                    .update(themeMap);
                                AudioManager.instance.playOrPause();
                              },
                              icon: const Icon(Icons.play_arrow))
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: CustomTeheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('campaigns')
            .doc(widget.campaingId)
            .collection("players")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return searchingWidget("Buscando jogadores", context);
          }
          if (snapshot.data?.size == 0) {
            return searchingWidget("Aguardando jogadores", context);
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: snapshot.data!.docs.map(
                  (documents) {
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: CustomTeheme.buttons70,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(6),
                          color: CustomTeheme.buttons,
                        ),
                        width: width * 0.9,
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowPlayerTable(
                                      campaingId: widget.campaingId,
                                      playerId: documents.id,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      documents
                                              .data()
                                              .toString()
                                              .contains('name')
                                          ? documents.get('name')
                                          : 'NONAME',
                                      style: TextStyle(
                                          fontSize: width * 0.09,
                                          color: Colors.black),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        baseStats(
                                          context,
                                          width,
                                          documents,
                                          ("HP:${documents.get('hp')}"),
                                        ),
                                        baseStats(
                                          context,
                                          width,
                                          documents,
                                          "INI:${documents.get('iniciative')}",
                                        ),
                                        baseStats(
                                          context,
                                          width,
                                          documents,
                                          "ESQ:${documents.get('deslocamento')}",
                                        ),
                                      ],
                                    ),
                                    baseStats(
                                      context,
                                      width,
                                      documents,
                                      "${documents.get('dices_result')}",
                                    ),
                                    baseStats(
                                      context,
                                      width,
                                      documents,
                                      "${documents.get('roled_dice')}",
                                    ),
                                    baseStats(
                                      context,
                                      width,
                                      documents,
                                      "Dado:${documents.get('dice')}",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
