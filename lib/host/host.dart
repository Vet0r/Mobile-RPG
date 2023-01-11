// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators

import 'dart:math';

import 'package:audio_manager/audio_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_rpg/host/searching_for_players.dart';
import 'package:mobile_rpg/host/sow_player_table.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';

import '../standard_textfiel_decoration.dart';
import 'base_stats.dart';

class Host extends StatefulWidget {
  String? campaingId;
  int? appColor;
  Host({this.campaingId, this.appColor, super.key});

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
        backgroundColor: CustomTheme.buttons70[widget.appColor!],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: CustomTheme.buttons70[widget.appColor!],
                    content: SizedBox(
                      height: height * 0.20,
                      child: Column(
                        children: [
                          TextField(
                            style: TextStyle(
                                color: CustomTheme.text[widget.appColor!]),
                            decoration: standardTextFieldDecoration(
                                "mp3 Link", widget.appColor!),
                            controller: controller,
                            cursorColor: CustomTheme.white[widget.appColor!],
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
      backgroundColor: CustomTheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('campaigns')
            .doc(widget.campaingId)
            .collection("players")
            .orderBy("ordem")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return searchingWidget("Buscando rede", context, widget.appColor!);
          }
          if (snapshot.data?.size == 0) {
            return searchingWidget(
                "Aguardando jogadores", context, widget.appColor!);
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
                            color: documents["is_npc"]
                                ? CustomTheme.errorCard[widget.appColor!]
                                : CustomTheme.buttons70[widget.appColor!],
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(6),
                          color: CustomTheme.buttons[widget.appColor!],
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
                                      appColor: widget.appColor,
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
                                          color: CustomTheme.black),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Ordem:",
                                          style: TextStyle(
                                              color: CustomTheme.black),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: SizedBox(
                                            width: 50,
                                            child: TextField(
                                              onSubmitted: (value) {
                                                FirebaseFirestore.instance
                                                    .collection('campaigns')
                                                    .doc(widget.campaingId)
                                                    .collection("players")
                                                    .doc(documents.id)
                                                    .update({
                                                  "ordem": int.parse(value),
                                                });
                                              },
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "  ${documents.get('ordem')}",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
