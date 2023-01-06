import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../styles/custom_theme.dart';

class PlayerDice extends StatefulWidget {
  String? playerId;
  String? campaignId;

  PlayerDice({
    Key? key,
    this.playerId,
    this.campaignId,
  }) : super(key: key);
  @override
  State<PlayerDice> createState() => _PlayerDiceState();
}

class _PlayerDiceState extends State<PlayerDice> {
  late WebViewPlusController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTeheme.backgroundTable,
      body: WebViewPlus(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: "assets/dado/dice/index.html",
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
        javascriptChannels: {
          JavascriptChannel(
            name: 'DiceResultChannel',
            onMessageReceived: (message) async {
              List<String> numberList = message.message.split(',');
              int sum = numberList.map(int.parse).reduce((a, b) => a + b);
              Map<String, dynamic> mapPlayer = <String, dynamic>{
                "dices_result": message.message,
                "dice": sum,
              };
              FirebaseFirestore.instance
                  .collection("campaigns")
                  .doc(widget.campaignId)
                  .collection("players")
                  .doc(widget.playerId)
                  .update(mapPlayer);
            },
          ),
          JavascriptChannel(
            name: 'DiceNumberChannel',
            onMessageReceived: (message) async {
              Map<String, dynamic> mapDice = <String, dynamic>{
                "roled_dice": message.message,
              };
              FirebaseFirestore.instance
                  .collection("campaigns")
                  .doc(widget.campaignId)
                  .collection("players")
                  .doc(widget.playerId)
                  .update(mapDice);
            },
          )
        },
      ),
    );
  }
}
