import 'package:flutter/material.dart';
import '../models/weapons.dart';
import '../models/character.dart';

class CombatScreen extends StatefulWidget {
  final Character character;
  final Weapon weapon;

  const CombatScreen({required this.character, required this.weapon, super.key});

  @override
  CombatScreenState createState() => CombatScreenState();
}

class CombatScreenState extends State<CombatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: null);
  }
}
