import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile_rpg/player/create_new_player.dart';
import 'package:mobile_rpg/player/player.dart';

class ChoseYourName extends StatefulWidget {
  const ChoseYourName({super.key});

  @override
  State<ChoseYourName> createState() => _ChoseYourNameState();
}

class _ChoseYourNameState extends State<ChoseYourName> {
  String? playerId = "";
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Escolha o seu nome"),
              TextField(
                controller: nameController,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (nameController.text == "") {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  content: Text("Digite um nome válido"),
                );
              },
            );
          } else {
            playerId = await createNewPlayer(nameController.text);
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Player(
                  playerId: playerId,
                ),
              ),
            );
          }
        },
        tooltip: 'Próximo',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
