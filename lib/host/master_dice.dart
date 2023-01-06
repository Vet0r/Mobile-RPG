import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../styles/custom_theme.dart';

class MasterDice extends StatefulWidget {
  const MasterDice({super.key});

  @override
  State<MasterDice> createState() => _MasterDiceState();
}

class _MasterDiceState extends State<MasterDice> {
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
            },
          ),
          JavascriptChannel(
            name: 'DiceNumberChannel',
            onMessageReceived: (message) async {},
          )
        },
      ),
    );
  }
}
