// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile_rpg/player/dice.dart';
import 'package:mobile_rpg/player/player_app_bar.dart';
import 'package:mobile_rpg/player/retangular_fields_for_table.dart';

import 'circular2_fields_for_table.dart';
import 'circular_fields_for_table.dart';
import 'fields_for_table.dart';

class Player extends StatefulWidget {
  String? playerId;
  String? campaignId;

  Player({
    Key? key,
    this.playerId,
    this.campaignId,
  }) : super(key: key);
  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: playerAppBar(widget.campaignId, widget.playerId, context),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('campaigns')
            .doc(widget.campaignId)
            .collection("players")
            .doc(widget.playerId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return snapshot.data!.exists
                ? ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.brown,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  fieldsFortable(
                                      'level', 'Level', context, snapshot.data),
                                  fieldsFortable(
                                      'xp', 'XP', context, snapshot.data),
                                ],
                              ),
                              const Divider(
                                height: 0.1,
                                thickness: 2,
                              ),
                              fieldsFortable(
                                  'race', 'Raça', context, snapshot.data),
                              fieldsFortable(
                                  'class', 'Classe', context, snapshot.data),
                              fieldsFortable(
                                  'hp', 'HP', context, snapshot.data),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  circularFieldsFortable(
                                      'force', 'Força', context, snapshot.data),
                                  circularFieldsFortable('dex', 'Destreza',
                                      context, snapshot.data),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  circularFieldsFortable('inteligence',
                                      'Inteligência', context, snapshot.data),
                                  circularFieldsFortable('knologe', 'Sabedoria',
                                      context, snapshot.data),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  circularFieldsFortable('charisam', 'Carisma',
                                      context, snapshot.data),
                                  circularFieldsFortable('constitution',
                                      'Constituição', context, snapshot.data),
                                ],
                              ),
                              const Divider(
                                height: 0.1,
                                thickness: 2,
                              ),
                              fieldsFortable(
                                  'dice', 'Dado', context, snapshot.data),
                              diceForTable(widget.campaignId!, 'dice', 'Dado',
                                  context, snapshot.data),
                              const Divider(
                                height: 0.1,
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  circular2FieldsFortable('armor', 'Armadura',
                                      context, snapshot.data),
                                  circular2FieldsFortable('iniciative',
                                      'Iniciativa', context, snapshot.data),
                                  circular2FieldsFortable('deslocamento',
                                      'Deslocamento', context, snapshot.data),
                                ],
                              ),
                              const Divider(
                                height: 0.1,
                                thickness: 2,
                              ),
                              Column(children: [
                                retangularFieldsFortable(
                                    'hp',
                                    'Pontos de vida Atuais',
                                    context,
                                    snapshot.data,
                                    true),
                                retangularFieldsFortable(
                                    'hp_temp',
                                    'Pontos de vida temporários',
                                    context,
                                    snapshot.data,
                                    false),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Container();
          }
        },
      ),
    );
  }
}
