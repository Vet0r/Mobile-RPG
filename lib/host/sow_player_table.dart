import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_rpg/host/searching_for_players.dart';
import 'package:mobile_rpg/host/widgets/circular_field_for_table2_master.dart';
import 'package:mobile_rpg/host/widgets/circular_field_for_table_master.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomTeheme.backgroundTable,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('campaigns')
            .doc(widget.campaingId)
            .collection("players")
            .doc(widget.playerId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return searchingWidget("Buscando jogador", context);
          } else {
            return ListView(children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshot.data!.get('name'),
                            style: TextStyle(
                                fontSize: width * 0.1,
                                color: CustomTeheme.text),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: CustomTeheme.buttons70,
                                    content: SizedBox(
                                      height: height * 0.10,
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
                            'force', 'Força', context, snapshot.data!,
                            fieldColor: CustomTeheme.buttons),
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
                        fieldsFortableMaster(
                          true,
                          widget.campaingId!,
                          'dice',
                          'Dado',
                          context,
                          snapshot.data!,
                          canEdit: snapshot.data!["loading_dice"],
                        ),
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
                            style: TextStyle(
                                fontSize: 20, color: CustomTeheme.text),
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
                                color: CustomTeheme.text,
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
                          icon: Icon(Icons.square_rounded,
                              color: CustomTeheme.text),
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
