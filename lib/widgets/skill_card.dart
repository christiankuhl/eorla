import 'package:flutter/material.dart';

class SkillCard extends StatelessWidget {
  final String skillName;
  final VoidCallback onTap;

  const SkillCard({required this.skillName, required this.onTap, super.key});

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
            skillName,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
