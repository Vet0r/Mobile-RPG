import 'package:flutter/material.dart';
import 'package:mobile_rpg/host/create_campaing.dart';
import 'package:mobile_rpg/player/widgets/chose_your_name.dart';

initButton(BuildContext context, bool isMaster) {
  return TextButton(
    onPressed: isMaster
        ? () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreatCampaing()),
            );
          }
        : () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChoseYourName()),
            );
          },
    child: Container(
      color: Colors.brown,
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.05,
      child: Center(
        child: Text(
          isMaster ? "Mestre" : "Jogador",
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}
