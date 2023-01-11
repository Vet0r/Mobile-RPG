import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d20/d20.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_rpg/host/player_table.dart';
import 'package:mobile_rpg/host/searching_for_players.dart';
import 'package:mobile_rpg/host/widgets/circular_field_for_table2_master.dart';
import 'package:mobile_rpg/host/widgets/circular_field_for_table_master.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';
import '../items_screen.dart';
import '../player/player_skills.dart';
import 'master_dice.dart';
import 'widgets/button_delete_player.dart';
import 'widgets/fields_for_table_master.dart';

class ShowPlayerTable extends StatefulWidget {
  String? campaingId;
  String? playerId;
  int? appColor;
  ShowPlayerTable({this.appColor, this.campaingId, super.key, this.playerId});

  @override
  State<ShowPlayerTable> createState() => _ShowPlayerTableState();
}

class _ShowPlayerTableState extends State<ShowPlayerTable> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final pages = [
      PlayerTable(
        appColor: widget.appColor,
        campaingId: widget.campaingId,
        playerId: widget.playerId,
      ),
      PlayerSkills(
        appColor: widget.appColor,
        playerId: widget.playerId,
        campaignId: widget.campaingId,
      ),
      ItemsScreen(
        appColor: widget.appColor,
        playerId: widget.playerId,
        campaingId: widget.campaingId,
      ),
      MasterDice(appColor: widget.appColor),
    ];
    return Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: NavigationBar(
          backgroundColor: CustomTheme.backgroundTable[widget.appColor!],
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.drive_file_rename_outline),
              label: 'Ficha',
            ),
            NavigationDestination(
              icon: Icon(Icons.skateboarding),
              label: 'Skills',
            ),
            NavigationDestination(
              icon: Icon(MdiIcons.sword),
              label: 'Itens',
            ),
            NavigationDestination(
              icon: Icon(MdiIcons.diceD20),
              label: 'Dado',
            ),
          ],
          onDestinationSelected: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          selectedIndex: _currentIndex,
        ),
        backgroundColor: CustomTheme.buttons70[widget.appColor!]);
  }
}
