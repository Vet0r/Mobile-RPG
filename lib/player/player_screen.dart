// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_manager/audio_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_rpg/player/retangular_fields_for_table.dart';
import 'package:mobile_rpg/player/widgets/circular_textField.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';

import '../host/widgets/fields_for_table_master.dart';
import 'widgets/circular2_fields_for_table.dart';
import 'widgets/circular_fields_for_table.dart';
import 'fields_for_table.dart';

class PlayerScreen extends StatefulWidget {
  String? playerId;
  String? campaignId;
  int? appColor;

  PlayerScreen({
    Key? key,
    this.appColor,
    this.playerId,
    this.campaignId,
  }) : super(key: key);
  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
                        color: CustomTheme.buttons[widget.appColor!],
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
                                } else if (snapshot.data!["theme_is_playng"] ==
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                fieldsFortable(
                                    'level', 'Level', context, snapshot.data),
                                fieldsFortable(
                                    'money', '\$', context, snapshot.data),
                              ],
                            ),
                            const Divider(
                              height: 0.1,
                              thickness: 2,
                            ),
                            fieldsFortable(
                                'race', 'Etnia', context, snapshot.data),
                            fieldsFortable(
                                'class', 'Classe', context, snapshot.data),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                circularFieldsFortable(
                                    'force', 'Força', context, snapshot.data),
                                circularFieldsFortable(
                                    'dex', 'Destreza', context, snapshot.data),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                circularFieldsFortable('inteligence',
                                    'Inteligência', context, snapshot.data),
                                circularFieldsFortable('knologe', 'Sentidos',
                                    context, snapshot.data),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                circularFieldsFortable('charisma', 'Social',
                                    context, snapshot.data),
                                circularFieldsFortable('constitution',
                                    'Constituição', context, snapshot.data),
                              ],
                            ),
                            const Divider(
                              height: 0.1,
                              thickness: 2,
                            ),
                            const Divider(
                              height: 0.1,
                              thickness: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            WeaponsAndArmorsTextField(
                              "weapon0",
                              "weapon1",
                              "weapon2",
                              "armor0",
                              "armor1",
                              "Armas e Armaduras",
                              context,
                              widget.playerId!,
                              widget.campaignId!,
                              snapshot.data,
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
                            const Divider(
                              height: 0.1,
                              thickness: 2,
                            ),
                            Text("Feitiços e Itens encantados"),
                            fieldsFortableMaster(
                              false,
                              widget.campaignId!,
                              'magic1',
                              '',
                              context,
                              snapshot.data!,
                              widget.appColor!,
                            ),
                            fieldsFortableMaster(
                              false,
                              widget.campaignId!,
                              'magic2',
                              '',
                              context,
                              snapshot.data!,
                              widget.appColor!,
                            ),
                            fieldsFortableMaster(
                              false,
                              widget.campaignId!,
                              'magic3',
                              '',
                              context,
                              snapshot.data!,
                              widget.appColor!,
                            ),
                            fieldsFortableMaster(
                              false,
                              widget.campaignId!,
                              'magic4',
                              '',
                              context,
                              snapshot.data!,
                              widget.appColor!,
                            ),
                            fieldsFortableMaster(
                              false,
                              widget.campaignId!,
                              'magic5',
                              '',
                              context,
                              snapshot.data!,
                              widget.appColor!,
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
