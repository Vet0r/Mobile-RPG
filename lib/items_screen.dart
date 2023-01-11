import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_rpg/styles/custom_theme.dart';

class ItemsScreen extends StatefulWidget {
  String? campaingId;
  String? playerId;
  int? appColor;
  ItemsScreen({this.appColor, this.campaingId, super.key, this.playerId});
  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final _controller = TextEditingController();
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadText();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _loadText() async {
    final snapshot = await _firestore
        .collection('campaigns')
        .doc(widget.campaingId)
        .collection("players")
        .doc(widget.playerId)
        .get();
    _controller.text = snapshot.data()!["itens"];
  }

  void _saveText() {
    _firestore
        .collection('campaigns')
        .doc(widget.campaingId)
        .collection("players")
        .doc(widget.playerId)
        .update({
      "itens": _controller.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.buttons[widget.appColor!],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: null, // aceita qualquer número de linhas
              decoration: const InputDecoration(
                hintText: "Digite aqui",
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _saveText,
              child: const Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
