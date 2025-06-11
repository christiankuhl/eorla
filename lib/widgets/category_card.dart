import 'package:flutter/material.dart';

class SkillGroupCard extends StatelessWidget {
  final String skillGroupName;
  final VoidCallback onTap;

  const SkillGroupCard({required this.skillGroupName, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(8),
        child: Container(
          height: 80,
          alignment: Alignment.center,
          child: Text(
            skillGroupName,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
