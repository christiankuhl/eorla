import 'package:flutter/material.dart';

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
          child: Text(
            weaponName,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
