import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';
import 'package:mobile_rpg/init_button.dart';

import 'check_user.dart';

class ButtonsChose extends StatelessWidget {
  ButtonsChose({super.key, required this.userData});
  User userData;
  @override
  Widget build(BuildContext context) {
    checkUser(userData);
    return Scaffold(
      floatingActionButton: signOutButton(context),
      backgroundColor: CustomTeheme.background,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            initButton(context, true),
            const SizedBox(
              width: 10,
            ),
            initButton(context, false),
          ],
        ),
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
