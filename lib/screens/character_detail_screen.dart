import 'package:flutter/material.dart';
import '../models/character.dart';
import 'character_selection_screen.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailScreen({required this.character, super.key});

  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final c = widget.character;

    Widget statRow(String label, int value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value.toString())],
      );
    }

    Widget modifierRow(
      String label,
      int value,
      VoidCallback onIncrement,
      VoidCallback onDecrement,
    ) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Row(
            children: [
              IconButton(icon: Icon(Icons.remove), onPressed: onDecrement),
              Text(value.toString()),
              IconButton(icon: Icon(Icons.add), onPressed: onIncrement),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(c.name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(backgroundImage: c.avatar?.image, 
            radius: 60),
            SizedBox(height: 16),
            Text(
              'Stats',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CharacterSelectionScreen()),
                );
              },
              child: Text('Switch Character'),
            ),

            statRow('Mut (MU)', c.mu),
            statRow('Klugheit (KL)', c.kl),
            statRow('Intuition (IN)', c.in_),
            statRow('Charisma (CH)', c.ch),
            statRow('Fingerfertigkeit (FF)', c.ff),
            statRow('Gewandheit (GE)', c.ge),
            statRow('Konstitution (KO)', c.ko),
            statRow('Körperkraft (KK)', c.kk),
            SizedBox(height: 16),
            Text(
              'Modifiers',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            modifierRow(
              'Belastung',
              c.belastung,
              () => setState(() {
                if (c.belastung < 4) c.belastung++;
              }),
              () => setState(() {
                if (c.belastung > 0) c.belastung--;
              }),
            ),
            modifierRow(
              'Betäubung',
              c.betaubung,
              () => setState(() {
                if (c.betaubung < 4) c.betaubung++;
              }),
              () => setState(() {
                if (c.betaubung > 0) c.betaubung--;
              }),
            ),
            modifierRow(
              'Entrückung',
              c.entrueckung,
              () => setState(() {
                if (c.entrueckung < 4) c.entrueckung++;
              }),
              () => setState(() {
                if (c.entrueckung > 0) c.entrueckung--;
              }),
            ),
            modifierRow(
              'Furcht',
              c.furcht,
              () => setState(() {
                if (c.furcht < 4) c.furcht++;
              }),
              () => setState(() {
                if (c.furcht > 0) c.furcht--;
              }),
            ),
            modifierRow(
              'Paralyse',
              c.paralyse,
              () => setState(() {
                if (c.paralyse < 4) c.paralyse++;
              }),
              () => setState(() {
                if (c.paralyse > 0) c.paralyse--;
              }),
            ),
            modifierRow(
              'Schmerz',
              c.schmerz,
              () => setState(() {
                if (c.schmerz < 4) c.schmerz++;
              }),
              () => setState(() {
                if (c.schmerz > 0) c.schmerz--;
              }),
            ),
            modifierRow(
              'Verwirrung',
              c.verwirrung,
              () => setState(() {
                if (c.verwirrung < 4) c.verwirrung++;
              }),
              () => setState(() {
                if (c.verwirrung > 0) c.verwirrung--;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
