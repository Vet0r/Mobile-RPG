// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:audio_manager/audio_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile_rpg/player/widgets/dice.dart';
import 'package:mobile_rpg/player/player_app_bar.dart';
import 'package:mobile_rpg/player/retangular_fields_for_table.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';

import 'widgets/circular2_fields_for_table.dart';
import 'widgets/circular_fields_for_table.dart';
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
      backgroundColor: CustomTeheme.buttons,
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
                          color: CustomTeheme.buttons,
                          child: Column(
                            children: [
                              //AudioManager.instance.playOrPause();
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('campaigns')
                                    .doc(widget.campaignId)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: Container(),
                                    );
                                  } else if (snapshot
                                          .data!["theme_is_playng"] ==
                                      true) {
                                    AudioManager.instance
                                        .start(
                                      snapshot.data!["theme_song"],
                                      "Mobile RPG",
                                      desc: "Mobile RPG Theme",
                                      cover:
                                          "assets/pngfind.com-formatura-png-2075195.png",
                                    )
                                        .then(
                                      (err) {
                                        print(
                                            "ERRO AQUI $err -------------------");
                                      },
                                    );
                                    AudioManager.instance.seekTo(
                                      parseDuration(
                                        snapshot.data!["theme_time"],
                                      ),
                                    );
                                    return Container();
                                  } else {
                                    AudioManager.instance.toPause();
                                  }
                                  return Container();
                                },
                              ),
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
                                  circularFieldsFortable('charisma', 'Carisma',
                                      context, snapshot.data),
                                  circularFieldsFortable('constitution',
                                      'Constituição', context, snapshot.data),
                                ],
                              ),
                              const Divider(
                                height: 0.1,
                                thickness: 2,
                              ),
                              snapshot.data!["loading_dice"] == true
                                  ? CircularProgressIndicator()
                                  : fieldsFortable(
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
                              Column(
                                children: [
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
                                ],
                              ),
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

Duration parseDuration(String s) {
  int hours = 0;
  int minutes = 0;
  int micros;
  List<String> parts = s.split(':');
  if (parts.length > 2) {
    hours = int.parse(parts[parts.length - 3]);
  }
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }
  micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
  return Duration(hours: hours, minutes: minutes, microseconds: micros);
}
