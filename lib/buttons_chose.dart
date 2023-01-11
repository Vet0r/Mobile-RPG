import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';
import 'package:mobile_rpg/init_button.dart';

import 'check_user.dart';

class ButtonsChose extends StatefulWidget {
  ButtonsChose({super.key, required this.userData});
  User userData;

  @override
  State<ButtonsChose> createState() => _ButtonsChoseState();
}

class _ButtonsChoseState extends State<ButtonsChose> {
  @override
  Widget build(BuildContext context) {
    void changeColor(Color newColor) {
  setState(() {
    // Altera o tema do aplicativo para um novo tema com a nova cor especificada
   var  _themeData = _themeData.copyWith(
      primaryColor: newColor,
    );
  });
}

    checkUser(widget.userData);
    return Scaffold(
      floatingActionButton: signOutButton(context),
      backgroundColor: CustomTeheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.height * 0.1,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Image.asset("assets/pngfind.com-formatura-png-2075195.png"),
          ),
          Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    initButton(context, true),
                    const SizedBox(
                      width: 10,
                    ),
                    initButton(context, false),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.06),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: CustomTeheme.buttons,
                    ),
                    width: MediaQuery.of(context).size.width*0.12,
                    height: MediaQuery.of(context).size.width*0.12,
                    child: Center(
                      child: IconButton(onPressed: () {
                        showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text('Escolha a cor do tema'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            TextButton(
              child: CircleAvatar(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                // Altera a cor do tema para vermelho
                changeColor(Colors.red);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: CircleAvatar(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                // Altera a cor do tema para verde
                changeColor(Colors.green);
                Navigator.of(context).pop();
              },
            ),
            // Adicione mais botões de opção de cor aqui
          ],
        ),
      ),
    );
  },
);

                      }, icon: const Icon(Icons.settings), ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  signOutButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: CustomTeheme.errorCard,
      onPressed: () => FirebaseUIAuth.signOut(
        context: context,
        auth: FirebaseAuth.instance,
      ),
      child: const Icon(Icons.logout),
    );
  }
}
