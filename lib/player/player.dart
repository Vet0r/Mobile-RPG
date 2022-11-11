// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile_rpg/player/dice.dart';
import 'package:mobile_rpg/player/player_app_bar.dart';

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
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.brown,
                      child: Column(
                        children: [
                          const Divider(
                            height: 0.1,
                            thickness: 2,
                          ),
                          fielsFortable(
                              'level', 'Level', context, snapshot.data),
                          const Divider(
                            height: 0.1,
                            thickness: 2,
                          ),
                          fielsFortable('hp', 'HP', context, snapshot.data),
                          const Divider(
                            height: 0.1,
                            thickness: 2,
                          ),
                          fielsFortable('mana', 'Mana', context, snapshot.data),
                          const Divider(
                            height: 0.1,
                            thickness: 2,
                          ),
                          fielsFortable(
                              'stamina', 'Stamina', context, snapshot.data),
                          const Divider(
                            height: 0.1,
                            thickness: 2,
                          ),
                          fielsFortable('xp', 'XP', context, snapshot.data),
                          const Divider(
                            height: 0.1,
                            thickness: 2,
                          ),
                          fielsFortable('dice', 'Dado', context, snapshot.data),
                          const Divider(
                            height: 0.1,
                            thickness: 2,
                          ),
                          diceForTable(widget.campaignId!, 'dice', 'Dado',
                              context, snapshot.data),
                        ],
                      ),
                    ),
                  )
                : Container();
          }
        },
      ),
    );
  }
}
