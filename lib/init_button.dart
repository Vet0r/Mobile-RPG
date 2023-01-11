import 'package:flutter/material.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';
import 'package:mobile_rpg/host/create_campaing.dart';
import 'package:mobile_rpg/player/widgets/chose_your_name.dart';
import 'package:mobile_rpg/styles/strings.dart';

initButton(BuildContext context, bool isMaster, int appColor) {
  return TextButton(
    onPressed: isMaster
        ? () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreatCampaing(appColor: appColor)),
            );
          }
        : () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChoseYourName(appColor: appColor)),
            );
          },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: CustomTheme.buttons[appColor],
      ),
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.05,
      child: Center(
        child: Text(
          isMaster ? StringsAppContent.mestre : StringsAppContent.jogador,
          style: TextStyle(color: CustomTheme.black),
        ),
      ),
    ),
  );
}
