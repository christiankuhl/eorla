import 'package:eorla/models/rules.dart';
import 'package:flutter/material.dart';
import '../models/character.dart';
import '../models/weapons.dart';
import '../models/special_abilities.dart';
import '../widgets/character_card.dart';
import '../widgets/widget_helpers.dart';
import '../widgets/weapon_card.dart';

class CombatScreen extends StatefulWidget {
  final Character character;
  final Weapon weapon;

  const CombatScreen({
    required this.character,
    required this.weapon,
    super.key,
  });

  @override
  State<CombatScreen> createState() => _CombatScreenState();
}

class _CombatScreenState extends State<CombatScreen> {
  int modifier = 0;
  SpecialAbility? selectedSpecial;

  void rollCombat(CombatActionType action) {
    final engine = CombatRoll.fromWeapon(widget.character, widget.weapon);
    final result = engine.roll(action, modifier);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => CombatResultScreen(result: result),
    //   ),
    // );
  }

  void rollDamage() {
    // final damage = widget.weapon.rollDamage();
    // showDialog(
    //   context: context,
    //   builder: (_) => AlertDialog(
    //     title: Text('Schaden'),
    //     content: Text('Du verursachst $damage Schaden.'),
    //     actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final List<SpecialAbility> specialOptions =
        widget.character.abilities ?? [];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
              height: 100, // Adjust as needed for your CharacterCard
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                    iconSize: 32,
                  ),
                  Expanded(
                    child: CharacterCard(),
                  ),
                ],
                ),
              ), 

              weaponInfoCard(widget.weapon, widget.character),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kampfsonderfertigkeiten",
                        style: TextStyle(fontSize: 18),
                      ),
                      DropdownButton<SpecialAbility?>(
                        value: selectedSpecial,
                        isExpanded: true,
                        hint: Text("Wählen..."),
                        items: [
                          DropdownMenuItem<SpecialAbility?>(
                            value: null,
                            child: Text("– Keine Sonderfertigkeit –"),
                          ),
                          ...specialOptions.map(
                            (ability) => DropdownMenuItem<SpecialAbility?>(
                              value: ability,
                              child: Text(ability.toString()),
                            ),
                          ),
                        ],
                        onChanged: (val) =>
                            setState(() => selectedSpecial = val),
                      ),
                    ],
                  ),
                ),
              ),

              Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: modifierRow(
                    "Modifikator",
                    modifier,
                    () {
                      setState(() => modifier++);
                    },
                    () {
                      setState(() => modifier--);
                    },
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 6,
                ),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => rollCombat(CombatActionType.attack),
                      child: Text("Attacke"),
                    ),
                    ElevatedButton(
                      onPressed: () => rollCombat(CombatActionType.parry),
                      child: Text("Parade"),
                    ),
                    ElevatedButton(
                      onPressed: () => rollCombat(CombatActionType.dodge),
                      child: Text("Ausweichen"),
                    ),
                    OutlinedButton(
                      onPressed: rollDamage,
                      child: Text("Schaden"),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
