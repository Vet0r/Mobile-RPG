import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_rpg/host/searching_for_players.dart';
import 'package:mobile_rpg/host/sow_player_table.dart';
import 'package:mobile_rpg/host/widgets/circular_field_for_table2_master.dart';
import 'package:mobile_rpg/host/widgets/circular_field_for_table_master.dart';

import '../player/widgets/dice.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey,
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
                        width: 100,
                        color: Colors.brown,
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
                                      style: const TextStyle(
                                          fontSize: 30, color: Colors.black),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                              border: Border.all(
                                                width: 3,
                                                color: Colors.black26,
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                            child: Text(
                                              "HP:" +
                                                  documents
                                                      .get('hp')
                                                      .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(12),
                                            ),
                                            border: Border.all(
                                              width: 3,
                                              color: Colors.black26,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          child: Text(
                                            "CA:" +
                                                documents.get('hp').toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Text(
                                              "RFE:" +
                                                  documents
                                                      .get('hp')
                                                      .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                              border: Border.all(
                                                width: 3,
                                                color: Colors.black26,
                                                style: BorderStyle.solid,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo c",
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.black),
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
