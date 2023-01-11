import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../styles/custom_theme.dart';

class PlayerSkills extends StatefulWidget {
  String? playerId;
  String? campaignId;

  PlayerSkills({
    Key? key,
    this.playerId,
    this.campaignId,
  }) : super(key: key);
  @override
  State<PlayerSkills> createState() => _PlayerSkillsState();
}

class _PlayerSkillsState extends State<PlayerSkills> {
  late WebViewPlusController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTeheme.buttons,
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
            Map<String, dynamic> mapSkills = snapshot.data!.get("skills");
            List<MapEntry<String, dynamic>> listMapSkills =
                mapSkills.entries.toList();
            listMapSkills.sort((a, b) => a.key.compareTo(b.key));
            return ListView.builder(
              itemCount: listMapSkills.length,
              itemBuilder: (context, index) {
                MapEntry<String, dynamic> item = listMapSkills[index];
                String chave = item.key;
                String valor = item.value.toString();
                return ListTile(
                  isThreeLine: false,
                  title: Text(chave),
                  subtitle: TextField(
                    decoration: InputDecoration(hintText: valor),
                    onChanged: (value) {
                      Map<String, dynamic> field = snapshot.data!["skills"];
                      Map<String, dynamic> newField = {
                        ...field,
                        chave: value,
                      };
                      Map<String, dynamic> fielMap = {
                        "skills": newField,
                      };
                      FirebaseFirestore.instance
                          .collection('campaigns')
                          .doc(widget.campaignId)
                          .collection('players')
                          .doc(widget.playerId)
                          .update(fielMap);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
