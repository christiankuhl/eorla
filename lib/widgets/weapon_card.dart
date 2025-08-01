import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../models/audit.dart';
import '../models/special_abilities.dart';
import '../models/rules.dart';
import '../models/weapons.dart';
import '../models/character.dart';
import 'widget_helpers.dart';

class WeaponCard extends StatelessWidget {
  final String weaponName;
  final VoidCallback onTap;

  const WeaponCard({required this.weaponName, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(8),
        child: Container(
          height: 60,
          alignment: Alignment.center,
          child: Text(weaponName, style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}

Widget weaponInfoCard(
  BuildContext context,
  Weapon weapon,
  Character character,
  SpecialAbility? specialAbilityBaseManeuvre,
  SpecialAbility? specialAbilitySpecialManeuvre,
  int modifier, {
  required VoidCallback onAttack,
  required VoidCallback onParry,
  required VoidCallback onDamage,
  VoidCallback? onDelete,
}) {
  final stats = CombatRoll.fromWeapon(
    character,
    weapon,
    specialAbilityBaseManeuvre,
    specialAbilitySpecialManeuvre,
    modifier,
  );

  ExplainedValue at = stats.targetValue(CombatActionType.attack);
  ExplainedValue pa = stats.targetValue(CombatActionType.parry);
  List<Widget> weaponStats = [
    statColumn(
      "AT",
      colouredValue(at),
      button: actionButton(Symbols.swords, onAttack, at.value > 0),
    ),
    if (!weapon.ct.hasNoParry)
      statColumn(
        "PA",
        colouredValue(pa),
        button: actionButton(Icons.security, onParry, pa.value > 0),
      ),
    statColumn(
      "TP",
      damageRollTextGenerator(
        weapon,
        character,
        specialAbilityBaseManeuvre,
        specialAbilitySpecialManeuvre,
        Theme.of(context).textTheme.bodyMedium,
        styleGood: styleGood,
        styleBad: styleBad,
      ),
      button: actionButton(Icons.whatshot, onDamage, true),
    ),
  ];

  return Card(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    weapon.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " (${weapon.ct.name})",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: weaponStats,
              ),
            ],
          ),
        ),
        if (onDelete != null)
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              icon: Icon(Icons.close, size: 20, color: Colors.blue),
              tooltip: 'Entfernen',
              splashRadius: 20,
              onPressed: onDelete,
            ),
          ),
      ],
    ),
  );
}

Widget statColumn(String label, Widget value, {Widget? button}) {
  List<Widget> col = [
    Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
    SizedBox(height: 4),
    value,
  ];
  return Row(
    children: [
      Column(children: col),
      if (button != null) button,
    ],
  );
}

class CombatResult {
  final int roll;
  final int target;
  final bool isSuccess;
  final CombatActionType action;
  final String successText;

  CombatResult(
    this.roll,
    this.target,
    this.isSuccess,
    this.action,
    this.successText,
  );
}

Widget dodgeCard(ExplainedValue aw, VoidCallback onPressed) {
  return Row(
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
              colouredValue(aw),
            ],
          ),
          actionButton(Icons.directions_run, onPressed, aw.value > 0),
        ],
      ),
    ],
  );
}
