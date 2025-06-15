import 'package:flutter/material.dart';
import '../models/character.dart';
import '../widgets/widget_helpers.dart';
import 'character_selection.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailScreen({required this.character, super.key});

  @override
  CharacterDetailScreenState createState() => CharacterDetailScreenState();
}

class CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final c = widget.character;

    Widget statRow(String label, int value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text(value.toString())],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(c.name),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CharacterSelectionScreen()),
              );
            },
            child: Text('Anderer Charakter'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(backgroundImage: c.avatar?.image, radius: 60),
            SizedBox(height: 16),
            Text(
              'Eigenschaften',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),

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
              'Zustände',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            modifierRow(
              'Belastung',
              c.state.belastung,
              () => setState(() {
                if (c.state.belastung < 4) c.state.belastung++;
              }),
              () => setState(() {
                if (c.state.belastung > 0) c.state.belastung--;
              }),
            ),
            modifierRow(
              'Betäubung',
              c.state.betaeubung,
              () => setState(() {
                if (c.state.betaeubung < 4) c.state.betaeubung++;
              }),
              () => setState(() {
                if (c.state.betaeubung > 0) c.state.betaeubung--;
              }),
            ),
            modifierRow(
              'Entrückung',
              c.state.entrueckung,
              () => setState(() {
                if (c.state.entrueckung < 4) c.state.entrueckung++;
              }),
              () => setState(() {
                if (c.state.entrueckung > 0) c.state.entrueckung--;
              }),
            ),
            modifierRow(
              'Furcht',
              c.state.furcht,
              () => setState(() {
                if (c.state.furcht < 4) c.state.furcht++;
              }),
              () => setState(() {
                if (c.state.furcht > 0) c.state.furcht--;
              }),
            ),
            modifierRow(
              'Paralyse',
              c.state.paralyse,
              () => setState(() {
                if (c.state.paralyse < 4) c.state.paralyse++;
              }),
              () => setState(() {
                if (c.state.paralyse > 0) c.state.paralyse--;
              }),
            ),
            modifierRow(
              'Schmerz',
              c.state.schmerz,
              () => setState(() {
                if (c.state.schmerz < 4) c.state.schmerz++;
              }),
              () => setState(() {
                if (c.state.schmerz > 0) c.state.schmerz--;
              }),
            ),
            modifierRow(
              'Verwirrung',
              c.state.verwirrung,
              () => setState(() {
                if (c.state.verwirrung < 4) c.state.verwirrung++;
              }),
              () => setState(() {
                if (c.state.verwirrung > 0) c.state.verwirrung--;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
