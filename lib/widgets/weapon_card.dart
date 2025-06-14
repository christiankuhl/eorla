import 'package:flutter/material.dart';
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
  Character character, {
  CombatResult? result,
}) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weapon.name,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              statColumn("AT", weapon.at.toString()),
              statColumn("PA", weapon.pa.toString()),
              statColumn("AW", "8"), // character.dodge.toString()),
              statColumn("TP", weapon.tpText()),
            ],
          ),
          if (result != null) ...[
            Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Wurf", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(result.roll.toString()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Zielwert", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(result.target.toString()),
              ],
            ),
            SizedBox(height: 8),
            Text(
              result.successText, // e.g. "Treffer!" or "Parade fehlgeschlagen"
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: result.isSuccess ? Colors.green : Colors.red,
              ),
            ),
          ],
        ],
      ),
    ),
  );
}

Widget statColumn(String label, String value) {
  return Column(
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 4),
      Text(value),
    ],
  );
}

class CombatResult {
  final int roll;
  final int target;
  final bool isSuccess;
  final CombatActionType action;
  final String successText;

  CombatResult(this.roll, this.target, this.isSuccess, this.action, this.successText);
}
