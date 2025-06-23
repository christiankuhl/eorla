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
  void rollCombat(CombatActionType action, Weapon weapon, SpecialAbility? specialAbility) {
    final engine = CombatRoll.fromWeapon(widget.character, weapon, specialAbility);
    final result = engine.roll(action, modifier);
    String title;
    switch (action) {
      case CombatActionType.attack:
        title = "${weapon.name} - Attacke";
      case CombatActionType.parry:
        title = "${weapon.name} - Parade";
      case CombatActionType.dodge:
        title = "Ausweichen";
    }
    String txt;
    if (result.length == 1) {
      txt = "${result[0].text()} (${result[0].targetValue} → 🎲 ${result[0].roll})";
    } else {
      txt = result.map((r) => "${r.context}: ${r.text()} (${r.targetValue} → 🎲 ${r.roll})").join("\n");
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

  void rollDamage(Weapon weapon, SpecialAbility? selectedSpecial) {
    final damage = damageRoll(weapon, widget.character, selectedSpecial);
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
        (widget.character.abilities ?? [])
            .where((a) => a.value.type != SpecialAbilityType.passive)
            .toList();

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
      Card(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Ausweichen",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text("AW", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text((widget.character.ge / 2).round().toString()),
                    ],
                  ),
                  actionButton(
                    Icons.directions_run,
                    // Note: The default weapon does not actually matter here.
                    () => rollCombat(
                      CombatActionType.dodge,
                      genericWeapons[CombatTechnique.raufen]!,
                      selectedSpecial,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ];
    for (Weapon weapon in widget.character.weapons ?? []) {
      tlChildren.add(
        weaponInfoCard(
          weapon,
          widget.character,
          selectedSpecial,
          onAttack: () => rollCombat(CombatActionType.attack, weapon, selectedSpecial),
          onParry: () => rollCombat(CombatActionType.parry, weapon, selectedSpecial),
          onDamage: () => rollDamage(weapon, selectedSpecial),
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
                  Weapon weapon = genericWeapons[selected]!;
                  genericAttack = weaponInfoCard(
                    weapon,
                    widget.character,
                    selectedSpecial,
                    onAttack: () => rollCombat(CombatActionType.attack, weapon, selectedSpecial),
                    onParry: () => rollCombat(CombatActionType.parry, weapon, selectedSpecial),
                    onDamage: () => rollDamage(weapon, selectedSpecial),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Kampfsonderfertigkeiten",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Visibility(
                    visible: selectedSpecial?.value.rules != null,
                    child: GestureDetector(
                      onTap: selectedSpecial?.value.rules != null
                          ? () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text(selectedSpecial.toString()),
                                  content: Text(selectedSpecial!.value.rules),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          : null,
                      child: Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.help_outline,
                          size: 18,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
