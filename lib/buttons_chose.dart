import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';
import 'package:mobile_rpg/init_button.dart';

import 'check_user.dart';
import 'host/searching_for_players.dart';

class ButtonsChose extends StatefulWidget {
  ButtonsChose({super.key, required this.userData});
  User userData;

  @override
  State<ButtonsChose> createState() => _ButtonsChoseState();
}

class _ButtonsChoseState extends State<ButtonsChose> {
  @override
  Widget build(BuildContext context) {
    void changeColor(int newColor) {
      setState(() {
        FirebaseFirestore.instance
            .collection("users")
            .doc(widget.userData.uid)
            .update(
          {
            "color": newColor,
          },
        );
      });
    }

    colorsChoosePopup(int color1, int color2, int color3) {
      List<Color> themeColorsList = [
        Colors.lightBlue,
        Colors.white,
        Colors.purple,
        Colors.green,
        Colors.yellow,
        Colors.pink,
        Colors.amber,
        Colors.orange,
        Colors.red,
      ];
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3.0,
                ),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: themeColorsList[color1],
              ),
            ),
            onPressed: () {
              changeColor(color1);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3.0,
                ),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: themeColorsList[color2],
              ),
            ),
            onPressed: () {
              changeColor(color2);
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3.0,
                ),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                backgroundColor: themeColorsList[color3],
              ),
            ),
            onPressed: () {
              changeColor(color3);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(widget.userData.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return searchingWidget("Buscando rede", context, 3);
          }
          checkUser(widget.userData);
          int appColor = snapshot.data!["color"];
          return Scaffold(
            floatingActionButton: signOutButton(context, appColor),
            backgroundColor: CustomTheme.background,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.height * 0.1,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Image.asset(
                      "assets/pngfind.com-formatura-png-2075195.png"),
                ),
                Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          initButton(context, true, appColor),
                          const SizedBox(
                            width: 10,
                          ),
                          initButton(context, false, appColor),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.06),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: CustomTheme.buttons[appColor],
                          ),
                          width: MediaQuery.of(context).size.width * 0.12,
                          height: MediaQuery.of(context).size.width * 0.12,
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Escolha a cor do tema'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            colorsChoosePopup(0, 1, 2),
                                            colorsChoosePopup(3, 4, 5),
                                            colorsChoosePopup(6, 7, 8),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.color_lens),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  signOutButton(BuildContext context, int appColor) {
    return FloatingActionButton(
      backgroundColor: CustomTheme.errorCard[appColor],
      onPressed: () => FirebaseUIAuth.signOut(
        context: context,
        auth: FirebaseAuth.instance,
      ),
      child: const Icon(Icons.logout),
    );
  }
}
