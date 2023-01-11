// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_rpg/player/player_dice.dart';
import 'package:mobile_rpg/player/player_screen.dart';
import 'package:mobile_rpg/player/player_app_bar.dart';
import 'package:mobile_rpg/player/player_skills.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';

import '../items_screen.dart';

class Player extends StatefulWidget {
  String? playerId;
  String? campaignId;
  int? appColor;

  Player({
    Key? key,
    this.playerId,
    this.campaignId,
    this.appColor,
  }) : super(key: key);
  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [
      PlayerScreen(
        appColor: widget.appColor,
        campaignId: widget.campaignId,
        playerId: widget.playerId,
      ),
      PlayerSkills(
        appColor: widget.appColor,
        playerId: widget.playerId,
        campaignId: widget.campaignId,
      ),
      ItemsScreen(
        appColor: widget.appColor,
        playerId: widget.playerId,
        campaingId: widget.campaignId,
      ),
      PlayerDice(
        appColor: widget.appColor,
        playerId: widget.playerId,
        campaignId: widget.campaignId,
      ),
    ];
    return Scaffold(
      backgroundColor: CustomTheme.buttons[widget.appColor!],
      appBar: playerAppBar(
          widget.campaignId, widget.playerId, context, widget.appColor!),
      bottomNavigationBar: NavigationBar(
        backgroundColor: CustomTheme.buttons70[widget.appColor!],
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
      body: pages[_currentIndex],
    );
  }
}
