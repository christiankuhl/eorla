import 'package:eorla/models/rules.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/character_manager.dart';
import '../models/weapons.dart';
import '../models/special_abilities.dart';
import '../models/audit.dart';
import '../models/character.dart';
import '../widgets/character_card.dart';
import '../widgets/widget_helpers.dart';
import '../widgets/weapon_card.dart';
import '../widgets/dice.dart';
import 'combat_technique_selection.dart';
import 'dice_rolls.dart';

class CombatScreen extends StatefulWidget {
  const CombatScreen({super.key});

  @override
  State<CombatScreen> createState() => _CombatScreenState();
}

class _CombatScreenState extends State<CombatScreen> {
  int modifier = 0;
  SpecialAbility? selectedSpecialBaseManeuvre;
  SpecialAbility? selectedSpecialSpecialManeuvre;
  Widget? genericAttack;

  Future<void> rollCombat(
    Character character,
    CombatActionType action,
    Weapon weapon,
    SpecialAbility? specialAbilityBaseManeuvre,
    SpecialAbility? specialAbilitySpecialManeuvre,
  ) async {
    final engine = CombatRoll.fromWeapon(
      character,
      weapon,
      specialAbilityBaseManeuvre,
      specialAbilitySpecialManeuvre,
      modifier,
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
    String detail;
    if (result.length == 1) {
      detail = result[0].targetValue.explanation
          .map((c) => c.toString())
          .join("\n");
    } else {
      detail = result
          .map((r) {
            String expl = r.targetValue.explanation
                .map((c) => c.toString())
                .join("\n");
            return "${r.resultContext}:\n$expl";
          })
          .join("\n\n");
    }

    await fadeDice(context, DiceAnimation.d20);

    if (!mounted) {
      return;
    }

    if (result.length == 1) {
      showDetailDialog(
        title,
        result[0].widget(context),
        result[0].resultText(context),
        detail,
        null,
        context,
      );
    } else {
      showDetailDialog(
        title,
        skillRollResultWidget(result, context),
        result[0].resultText(
          context,
        ), // FIXME: this is not technically correct, since for multiple attacks, individual attack rolls may fail
        detail,
        null,
        context,
      );
    }
  }

  Future<void> rollDamage(
    Character character,
    Weapon weapon,
    SpecialAbility? selectedSpecialBaseManeuvre,
    SpecialAbility? selectedSpecialSpecialManeuvre,
  ) async {
    final damage = damageRoll(
      weapon,
      character,
      selectedSpecialBaseManeuvre,
      selectedSpecialSpecialManeuvre,
    );

    // await fadeDice(context, DiceAnimation.d6);

    if (!mounted) {
      return;
    }

    String detail = damage.combinedResult.explanation
          .map((c) => c.toString())
          .join("\n");

    showDetailDialog(
      "${weapon.name} - Schaden",
      damage.widget(context),
      damage.resultText(context),
      detail,
      null,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final character = Provider.of<CharacterManager>(context).activeCharacter!;
    final List<SpecialAbility> specialOptionsBaseManeuvre =
        (character.abilities ?? [])
            .where((a) => a.value.type == SpecialAbilityType.baseManeuvre)
            .toList();
    final List<SpecialAbility> specialOptionsSpecialManeuvre =
        (character.abilities ?? [])
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

    ExplainedValue aw = CombatRoll.fromTechnique(
      character,
      CombatTechnique.raufen,
      selectedSpecialBaseManeuvre,
      selectedSpecialSpecialManeuvre,
      modifier,
    ).targetValue(CombatActionType.dodge);

    List<Widget> tlChildren = [
      Card(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: dodgeCard(
            aw,
            // Note: The default weapon does not actually matter here.
            () => rollCombat(
              character,
              CombatActionType.dodge,
              genericWeapons[CombatTechnique.raufen]!,
              selectedSpecialBaseManeuvre,
              selectedSpecialSpecialManeuvre,
            ),
          ),
        ),
      ),
    ];
    for (Weapon weapon in character.weapons ?? []) {
      tlChildren.add(
        weaponInfoCard(
          context,
          weapon,
          character,
          selectedSpecialBaseManeuvre,
          selectedSpecialSpecialManeuvre,
          modifier,
          onAttack: () => rollCombat(
            character,
            CombatActionType.attack,
            weapon,
            selectedSpecialBaseManeuvre,
            selectedSpecialSpecialManeuvre,
          ),
          onParry: () => rollCombat(
            character,
            CombatActionType.parry,
            weapon,
            selectedSpecialBaseManeuvre,
            selectedSpecialSpecialManeuvre,
          ),
          onDamage: () => rollDamage(
            character,
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
                    character,
                    selectedSpecialBaseManeuvre,
                    selectedSpecialSpecialManeuvre,
                    modifier,
                    onAttack: () => rollCombat(
                      character,
                      CombatActionType.attack,
                      weapon,
                      selectedSpecialBaseManeuvre,
                      selectedSpecialSpecialManeuvre,
                    ),
                    onParry: () => rollCombat(
                      character,
                      CombatActionType.parry,
                      weapon,
                      selectedSpecialBaseManeuvre,
                      selectedSpecialSpecialManeuvre,
                    ),
                    onDamage: () => rollDamage(
                      character,
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
