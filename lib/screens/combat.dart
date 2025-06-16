import 'package:eorla/models/rules.dart';
import 'package:flutter/material.dart';
import '../models/character.dart';
import '../models/weapons.dart';
import '../models/special_abilities.dart';
import '../widgets/character_card.dart';
import '../widgets/widget_helpers.dart';
import '../widgets/weapon_card.dart';
import 'combat_technique_selection.dart';

class CombatScreen extends StatefulWidget {
  final Character character;

  const CombatScreen({required this.character, super.key});

  @override
  State<CombatScreen> createState() => _CombatScreenState();
}

class _CombatScreenState extends State<CombatScreen> {
  int modifier = 0;
  SpecialAbility? selectedSpecial;
  Widget? genericAttack;

  // TODO: Prettify this!
  void rollCombat(CombatActionType action, Weapon weapon) {
    final engine = CombatRoll.fromWeapon(widget.character, weapon);
    final result = engine.roll(action, modifier);
    String txt = "${result.text()} (${engine.targetValue(action)} → 🎲 ${result.roll})";
    String title;
    switch (action) {
      case CombatActionType.attack:
        title = "${weapon.name} - Attacke";
      case CombatActionType.parry:
        title = "${weapon.name} - Parade";
      case CombatActionType.dodge:
        title = "Ausweichen";
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(txt),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void rollDamage(Weapon weapon) {
    final damage = damageRoll(weapon, widget.character);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Schaden'),
        content: Text('Dein Angriff verursacht $damage Trefferpunkt(e).'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<SpecialAbility> specialOptions =
        widget.character.abilities ?? [];

    List<Widget> tlChildren = [
      SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
              iconSize: 32,
            ),
            Expanded(child: CharacterCard()),
          ],
        ),
      ),
    ];
    for (Weapon weapon in widget.character.weapons ?? []) {
      tlChildren.add(
        weaponInfoCard(
          weapon,
          widget.character,
          onAttack: () => rollCombat(CombatActionType.attack, weapon),
          onParry: () => rollCombat(CombatActionType.parry, weapon),
          onDamage: () => rollDamage(weapon),
        ),
      );
    }
    if (genericAttack == null) {
      tlChildren.add(
        Card(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: InkWell(
            onTap: () async {
              final selected = await Navigator.push<CombatTechnique>(
                context,
                MaterialPageRoute(
                  builder: (_) => CombatTechniqueSelectionScreen(),
                  fullscreenDialog: true,
                ),
              );
              if (selected != null) {
                setState(() {
                  Weapon weapon = genericWeapon(selected);
                  genericAttack = weaponInfoCard(
                    weapon,
                    widget.character,
                    onAttack: () => rollCombat(CombatActionType.attack, weapon),
                    onParry: () => rollCombat(CombatActionType.parry, weapon),
                    onDamage: () => rollDamage(weapon),
                    onDelete: () => setState(() {
                      genericAttack = null;
                    }),
                  );
                });
              } else {
                setState(() {
                  genericAttack = null;
                });
              }
            },
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Opacity(
                opacity: 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 28),
                    SizedBox(width: 8),
                    Text("Andere Kampftechnik"),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      tlChildren.add(genericAttack!);
    }
    tlChildren += [
      Card(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Kampfsonderfertigkeiten", style: TextStyle(fontSize: 18)),
              DropdownButton<SpecialAbility?>(
                value: selectedSpecial,
                isExpanded: true,
                hint: Text("Wählen..."),
                items: [
                  DropdownMenuItem<SpecialAbility?>(
                    value: null,
                    child: Opacity(
                      opacity: 0.5,
                      child: Text("– Keine Sonderfertigkeit –"),
                    ),
                  ),
                  ...specialOptions.map(
                    (ability) => DropdownMenuItem<SpecialAbility?>(
                      value: ability,
                      child: Text(ability.toString()),
                    ),
                  ),
                ],
                onChanged: (val) => setState(() => selectedSpecial = val),
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
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(child: Column(children: tlChildren)),
      ),
    );
  }
}
