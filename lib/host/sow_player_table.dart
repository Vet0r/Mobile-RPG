import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_rpg/host/searching_for_players.dart';
import 'package:mobile_rpg/host/widgets/circular_field_for_table2_master.dart';
import 'package:mobile_rpg/host/widgets/circular_field_for_table_master.dart';
import 'widgets/button_delete_player.dart';
import 'widgets/fields_for_table_master.dart';

class PlayerTable extends StatefulWidget {
  String? campaingId;
  String? playerId;
  PlayerTable({this.campaingId, super.key, this.playerId});

  @override
  State<PlayerTable> createState() => _PlayerTableState();
}

class _PlayerTableState extends State<PlayerTable> {
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
            .doc(widget.playerId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return searchingWidget("Buscando jogador");
          } else {
            return ListView(children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshot.data!.get('name'),
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      child: Column(
                                        children: [
                                          const Text(
                                              "Deseja deletar o player?"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              buttonDelete(
                                                  widget.campaingId,
                                                  context,
                                                  true,
                                                  snapshot.data!),
                                              buttonDelete(
                                                  widget.campaingId,
                                                  context,
                                                  false,
                                                  snapshot.data!),
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
                    Row(
                      children: [
                        fieldsFortableMaster(true, widget.campaingId!, 'level',
                            'Level', context, snapshot.data!),
                        fieldsFortableMaster(true, widget.campaingId!, 'xp',
                            'XP', context, snapshot.data!),
                      ],
                    ),
                    const Divider(
                      height: 0.1,
                      thickness: 2,
                    ),
                    fieldsFortableMaster(false, widget.campaingId!, 'race',
                        'Raça', context, snapshot.data!),
                    fieldsFortableMaster(false, widget.campaingId!, 'class',
                        'Classe', context, snapshot.data!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        circularFieldsFortableMaster(true, widget.campaingId!,
                            'force', 'Força', context, snapshot.data!),
                        circularFieldsFortableMaster(true, widget.campaingId!,
                            'dex', 'Destreza', context, snapshot.data!),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        circularFieldsFortableMaster(
                            true,
                            widget.campaingId!,
                            'inteligence',
                            'Inteligência',
                            context,
                            snapshot.data!),
                        circularFieldsFortableMaster(true, widget.campaingId!,
                            'knologe', 'Sabedoria', context, snapshot.data!),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        circularFieldsFortableMaster(true, widget.campaingId!,
                            'charisma', 'Carisma', context, snapshot.data!),
                        circularFieldsFortableMaster(
                            true,
                            widget.campaingId!,
                            'constitution',
                            'Constituição',
                            context,
                            snapshot.data!),
                      ],
                    ),
                    const Divider(
                      height: 0.1,
                      thickness: 2,
                    ),
                    Row(
                      children: [
                        fieldsFortableMaster(true, widget.campaingId!, 'dice',
                            'Dado', context, snapshot.data!),
                        fieldsFortableMaster(
                            true,
                            widget.campaingId!,
                            'roled_dice',
                            'Dado Rolado',
                            context,
                            snapshot.data!),
                      ],
                    ),
                    const Divider(
                      height: 0.1,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        circularFieldsFortable2Master(true, widget.campaingId!,
                            'armor', 'Armadura', context, snapshot.data!),
                        circularFieldsFortable2Master(
                            true,
                            widget.campaingId!,
                            'iniciative',
                            'Iniciativa',
                            context,
                            snapshot.data!),
                        circularFieldsFortable2Master(
                            true,
                            widget.campaingId!,
                            'deslocamento',
                            'Deslocamento',
                            context,
                            snapshot.data!),
                      ],
                    ),
                    const Divider(
                      height: 0.1,
                      thickness: 2,
                    ),
                    Column(children: [
                      fieldsFortableMaster(
                        true,
                        widget.campaingId!,
                        'hp_total',
                        'HP Total',
                        context,
                        snapshot.data!,
                      ),
                      fieldsFortableMaster(
                        true,
                        widget.campaingId!,
                        'hp',
                        'HP',
                        context,
                        snapshot.data!,
                      ),
                      fieldsFortableMaster(
                        true,
                        widget.campaingId!,
                        'hp_temp',
                        'HP Temporário',
                        context,
                        snapshot.data!,
                      ),
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            "Dado: ${value.toString()}",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.27,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              border: Border.all(
                                width: 3,
                                color: Colors.black26,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: TextField(
                              controller: controller,
                              decoration: InputDecoration(),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            value = Random().nextInt(
                              int.parse(controller.text),
                            );
                            setState(() {
                              value;
                            });
                          },
                          icon: const Icon(Icons.square_rounded),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]);
          }
        },
      ),
    );
  }
}
