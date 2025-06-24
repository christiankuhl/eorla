import 'package:eorla/models/special_abilities.dart';
import 'package:eorla/widgets/widget_helpers.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../models/rules.dart';
import '../models/weapons.dart';
import '../models/character.dart';

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
  Weapon weapon,
  Character character,
  SpecialAbility? specialAbility, {
  required VoidCallback onAttack,
  required VoidCallback onParry,
  required VoidCallback onDamage,
  VoidCallback? onDelete,
}) {
  final stats = CombatRoll.fromWeapon(character, weapon, specialAbility);

  List<Widget> weaponStats = [
    statColumn(
      "AT",
      stats.targetValue(CombatActionType.attack).toString(),
      button: actionButton(Symbols.swords, onAttack),
    ),
    if (!weapon.ct.hasNoParry)
      statColumn(
        "PA",
        stats.targetValue(CombatActionType.parry).toString(),
        button: actionButton(Icons.security, onParry),
      ),
    statColumn(
      "TP",
      weapon.tpText(),
      button: actionButton(Icons.whatshot, onDamage),
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
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, fontStyle: FontStyle.italic),
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

Widget statColumn(String label, String value, {Widget? button}) {
  List<Widget> col = [
    Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
    SizedBox(height: 4),
    Text(value),
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
