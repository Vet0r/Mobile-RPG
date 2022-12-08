import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_rpg/host/searching_for_players.dart';
import 'package:mobile_rpg/host/sow_player_table.dart';
import 'package:mobile_rpg/host/widgets/circular_field_for_table2_master.dart';
import 'package:mobile_rpg/host/widgets/circular_field_for_table_master.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';

import '../player/widgets/dice.dart';
import '../standard_textfiel_decoration.dart';
import '../styles/strings.dart';
import 'base_stats.dart';
import 'widgets/button_delete_player.dart';
import 'widgets/fields_for_table_master.dart';
import 'master_dice.dart';

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
    var notes = TextEditingController();
    return Scaffold(
      backgroundColor: CustomTeheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('campaigns')
            .doc(widget.campaingId)
            .collection("players")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return searchingWidget("Buscando jogadores");
          }
          if (snapshot.data?.size == 0) {
            return searchingWidget("Aguardando jogadores");
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
                                    builder: (context) => PlayerTable(
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
                                          "CA:${documents.get('hp')}",
                                        ),
                                        baseStats(
                                          context,
                                          width,
                                          documents,
                                          "RFE:${documents.get('hp')}",
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
