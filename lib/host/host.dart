import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_rpg/host/searching_for_players.dart';

import '../player/dice.dart';
import 'button_delete_player.dart';
import 'fields_for_table_master.dart';
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
              child: ExpansionPanelList(
                children: snapshot.data!.docs.map((documents) {
                  return ExpansionPanel(
                    body: Container(
                      width: 100,
                      color: Colors.brown,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                documents.data().toString().contains('name')
                                    ? documents.get('name')
                                    : 'NONAME',
                                style: const TextStyle(fontSize: 30),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.grey,
                                        content: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.10,
                                          child: Column(
                                            children: [
                                              const Text(
                                                  "Deseja deletar o player?"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  buttonDelete(
                                                      widget.campaingId,
                                                      context,
                                                      true,
                                                      documents),
                                                  buttonDelete(
                                                      widget.campaingId,
                                                      context,
                                                      false,
                                                      documents),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 0.1,
                          thickness: 2,
                        ),
                        fieldsFortableMaster(widget.campaingId!, 'level',
                            'Level', context, documents),
                        const Divider(
                          height: 0.1,
                          thickness: 2,
                        ),
                        fieldsFortableMaster(
                            widget.campaingId!, 'hp', 'HP', context, documents),
                        const Divider(
                          height: 0.1,
                          thickness: 2,
                        ),
                        fieldsFortableMaster(
                            widget.campaingId!, 'xp', 'XP', context, documents),
                        const Divider(
                          height: 0.1,
                          thickness: 2,
                        ),
                        fieldsFortableMaster(widget.campaingId!, 'dice', 'Dado',
                            context, documents),
                        fieldsFortableMaster(widget.campaingId!, 'roled_dice',
                            'Dado Rolado', context, documents),
                        const Divider(
                          height: 0.1,
                          thickness: 2,
                        ),
                        TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                value = Random().nextInt(
                                  int.parse(controller.text),
                                );
                                setState(() {
                                  value;
                                });
                              },
                              icon: Text(value.toString()),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return Text("data");
                    },
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
