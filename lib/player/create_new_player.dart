import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<String> createNewPlayer(String name, String campaingDocId) async {
  Map<String, dynamic> skills = <String, dynamic>{
    "ABRIR_FECHADURAS": "",
    "ACROBACIAS": "",
    "ADESTRAR_ANIMAIS": "",
    "ARMADILHAS": "",
    "ARMAS_TRADICIONAIS": "",
    "ARMAS_DE_FOGO": "",
    "ARMEIRO": "",
    "ARREMESSAR_OBJETOS": "",
    "BLEFAR": "",
    "CAMUFLAGEM": "",
    "CAVALGAR": "",
    "CONHECIMENTO_DE_REGIÃO": "",
    "DEMOLIÇÃO": "",
    "DIPLOMACIA": "",
    "DISFARCES": "",
    "DISSIMULAÇÃO": "",
    "ENGENHARIA": "",
    "EQUILÍBRIO": "",
    "ESCALAR": "",
    "FALSIFICAR": "",
    "FURTIVO": "",
    "HERÁLDICA": "",
    "INTERROGAR": "",
    "JOGO": "",
    "LAÇAR": "",
    "LIDERAR": "",
    "LINGUAGEM_DE_SINAIS": "",
    "LUTA_DESARMADA": "",
    "MATEMÁTICA": "",
    "MECÂNICA": "",
    "MEDICINA": "",
    "MIRA_APIMORADA": "",
    "NAVEGAÇÃO_FLUVIAL": "",
    "NAVEGAÇÃO_MARÍTIMA": "",
    "OCULTISMO": "",
    "OPERAR_TELÉGRAFO": "",
    "PRIMEIROS_SOCORROS": "",
    "PUNGA": "",
    "RASTREAR": "",
    "SACAR_RÁPIDO": "",
    "SENTIR_MOTIVAÇÃO": "",
    "SOMBRA": "",
  };
  List<Map<String, dynamic>> weapons = [];
  for (var i = 0; i < 3; i++) {
    Map<String, dynamic> w = {
      "name$i": "",
      "weight$i": "",
      "damage$i": "",
    };
    weapons.add(w);
  }
  List<Map<String, dynamic>> armor = [];
  for (var i = 0; i < 2; i++) {
    Map<String, dynamic> w = {
      "name$i": "",
      "weight$i": "",
      "damageRed$i": "",
    };
    armor.add(w);
  }

  CollectionReference players = FirebaseFirestore.instance
      .collection('/campaigns')
      .doc(campaingDocId)
      .collection('players');

  Map<String, dynamic> mapPlayer = <String, dynamic>{
    "money": "0",
    "user_id": FirebaseAuth.instance.currentUser!.uid,
    "name": name,
    "hp": 15,
    "hp_temp": 0,
    "hp_total": 15,
    "armor": 0,
    "iniciative": 0,
    "deslocamento": 0,
    "xp": 0,
    "dice": "0",
    "level": 0,
    "roled_dice": "0",
    "race": "",
    "class": "",
    "force": 0,
    "dex": 0,
    "constitution": 0,
    "inteligence": 0,
    "knologe": 0,
    "charisma": 0,
    "forceMd": 0,
    "dexMd": 0,
    "constitutionMd": 0,
    "inteligenceMd": 0,
    "knologeMd": 0,
    "charismaMd": 0,
    "dices_result": "0",
    "magic1": "",
    "magic2": "",
    "magic3": "",
    "magic4": "",
    "magic5": "",
    "itens": "",
    "skills": skills,
    "armor0": armor[0],
    "armor1": armor[1],
    "weapon0": weapons[0],
    "weapon1": weapons[1],
    "weapon2": weapons[2],
  };

  DocumentReference playerId = await players.add(mapPlayer);
  return playerId.id;
}
