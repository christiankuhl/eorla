import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/character_manager.dart';

class CombatScreen extends StatefulWidget {
  const CombatScreen({super.key});

  @override
  CombatScreenState createState() => CombatScreenState();
}

class CombatScreenState extends State<CombatScreen> {
  @override
  Widget build(BuildContext context) {
    final character = Provider.of<CharacterManager>(context).activeCharacter;
    return Scaffold(body: null);
  }
}
