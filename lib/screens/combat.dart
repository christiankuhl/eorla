import 'package:eorla/models/rules.dart';
import 'package:flutter/material.dart';
import '../models/character.dart';
import '../models/weapons.dart';
import '../models/special_abilities.dart';
import '../widgets/character_card.dart';
import '../widgets/widget_helpers.dart';
import '../widgets/weapon_card.dart';
import 'combat_technique_selection.dart';
import 'dice_rolls.dart';

class CombatScreen extends StatefulWidget {
  final Character character;

  const CombatScreen({required this.character, super.key});

  @override
  State<CombatScreen> createState() => _CombatScreenState();
}

class _CombatScreenState extends State<CombatScreen> {
  int modifier = 0;
  SpecialAbility? selectedSpecialBaseManeuvre;
  SpecialAbility? selectedSpecialSpecialManeuvre;
  Widget? genericAttack;

  // TODO: Prettify this!
  Future<void> rollCombat(
    CombatActionType action,
    Weapon weapon,
    SpecialAbility? specialAbilityBaseManeuvre,
    SpecialAbility? specialAbilitySpecialManeuvre,
  ) async {
    final engine = CombatRoll.fromWeapon(
      widget.character,
      weapon,
      specialAbilityBaseManeuvre,
      specialAbilitySpecialManeuvre,
      modifier
    );
    final result = engine.roll(action);
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
      txt =
          "${result[0].text()} (${result[0].targetValue} → 🎲 ${result[0].roll})";
    } else {
      txt = result
          .map(
            (r) =>
                "${r.context}: ${r.text()} (${r.targetValue} → 🎲 ${r.roll})",
          )
          .join("\n");
    }

    await fadeDice(context, context.widget, DiceAnimation.d20);
    
    if (!mounted) {
      return;
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

  Future<void> rollDamage(
    Weapon weapon,
    SpecialAbility? selectedSpecialBaseManeuvre,
    SpecialAbility? selectedSpecialSpecialManeuvre,
  ) async {
    final damage = damageRoll(
      weapon,
      widget.character,
      selectedSpecialBaseManeuvre,
      selectedSpecialSpecialManeuvre,
    );
    
    await fadeDice(context, context.widget, DiceAnimation.d6);
    
    if (!mounted) {
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: damage.titleAsWidget(context),
        content: damage.contentAsWidget(context),
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
    final List<SpecialAbility> specialOptionsBaseManeuvre =
        (widget.character.abilities ?? [])
            .where((a) => a.value.type == SpecialAbilityType.baseManeuvre)
            .toList();
    final List<SpecialAbility> specialOptionsSpecialManeuvre =
        (widget.character.abilities ?? [])
            .where((a) => a.value.type == SpecialAbilityType.specialManeuvre)
            .toList();

    final characterCard = SizedBox(
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
    );

    List<Widget> tlChildren = [
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
                      selectedSpecialBaseManeuvre,
                      selectedSpecialSpecialManeuvre,
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
          context,
          weapon,
          widget.character,
          selectedSpecialBaseManeuvre,
          selectedSpecialSpecialManeuvre,
          modifier,
          onAttack: () => rollCombat(
            CombatActionType.attack,
            weapon,
            selectedSpecialBaseManeuvre,
            selectedSpecialSpecialManeuvre,
          ),
          onParry: () => rollCombat(
            CombatActionType.parry,
            weapon,
            selectedSpecialBaseManeuvre,
            selectedSpecialSpecialManeuvre,
          ),
          onDamage: () => rollDamage(
            weapon,
            selectedSpecialBaseManeuvre,
            selectedSpecialSpecialManeuvre,
          ),
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
                    context,
                    weapon,
                    widget.character,
                    selectedSpecialBaseManeuvre,
                    selectedSpecialSpecialManeuvre,
                    modifier,
                    onAttack: () => rollCombat(
                      CombatActionType.attack,
                      weapon,
                      selectedSpecialBaseManeuvre,
                      selectedSpecialSpecialManeuvre,
                    ),
                    onParry: () => rollCombat(
                      CombatActionType.parry,
                      weapon,
                      selectedSpecialBaseManeuvre,
                      selectedSpecialSpecialManeuvre,
                    ),
                    onDamage: () => rollDamage(
                      weapon,
                      selectedSpecialBaseManeuvre,
                      selectedSpecialSpecialManeuvre,
                    ),
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
                    child: Text("Basismanöver", style: TextStyle(fontSize: 18)),
                  ),
                  Visibility(
                    visible: selectedSpecialBaseManeuvre?.value.rules != null,
                    child: GestureDetector(
                      onTap: selectedSpecialBaseManeuvre?.value.rules != null
                          ? () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text(
                                    selectedSpecialBaseManeuvre.toString(),
                                  ),
                                  content: Text(
                                    selectedSpecialBaseManeuvre!.value.rules,
                                  ),
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
                value: selectedSpecialBaseManeuvre,
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
                  ...specialOptionsBaseManeuvre.map(
                    (ability) => DropdownMenuItem<SpecialAbility?>(
                      value: ability,
                      child: Text(ability.toString()),
                    ),
                  ),
                ],
                onChanged: (val) =>
                    setState(() => selectedSpecialBaseManeuvre = val),
              ),
            ],
          ),
        ),
      ),

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
                      "Spezialmanöver",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Visibility(
                    visible:
                        selectedSpecialSpecialManeuvre?.value.rules != null,
                    child: GestureDetector(
                      onTap: selectedSpecialSpecialManeuvre?.value.rules != null
                          ? () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text(
                                    selectedSpecialSpecialManeuvre.toString(),
                                  ),
                                  content: Text(
                                    selectedSpecialSpecialManeuvre!.value.rules,
                                  ),
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
                value: selectedSpecialSpecialManeuvre,
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
                  ...specialOptionsSpecialManeuvre.map(
                    (ability) => DropdownMenuItem<SpecialAbility?>(
                      value: ability,
                      child: Text(ability.toString()),
                    ),
                  ),
                ],
                onChanged: (val) =>
                    setState(() => selectedSpecialSpecialManeuvre = val),
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
        child: Column(
          children: [
            characterCard,
            Expanded(child: ListView(children: tlChildren)),
          ],
        ),
      ),
    );
  }
}
