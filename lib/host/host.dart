import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'fields_for_table_master.dart';

class Host extends StatefulWidget {
  const Host({super.key});

  @override
  State<Host> createState() => _HostState();
}

class _HostState extends State<Host> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('players').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Buscando players",
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: snapshot.data!.docs.map((documents) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      color: Colors.brown,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            documents.data().toString().contains('name')
                                ? documents.get('name')
                                : 'NONAME',
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                        const Divider(
                          height: 0.1,
                          thickness: 2,
                        ),
                        fielsFortableMaster('hp', 'HP', context, documents),
                        const Divider(
                          height: 0.1,
                          thickness: 2,
                        ),
                        fielsFortableMaster('mana', 'Mana', context, documents),
                        const Divider(
                          height: 0.1,
                          thickness: 2,
                        ),
                        fielsFortableMaster(
                            'stamina', 'Stamina', context, documents),
                        const Divider(
                          height: 0.1,
                          thickness: 2,
                        ),
                        fielsFortableMaster('xp', 'XP', context, documents),
                        const Divider(
                          height: 0.1,
                          thickness: 2,
                        ),
                        fielsFortableMaster('dice', 'Dado', context, documents),
                      ]),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
