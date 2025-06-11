import 'package:flutter/material.dart';
import '../models/skill_groups.dart';

class SkillGroupCard extends StatelessWidget {
  final SkillGroup skillGroup;
  final VoidCallback onTap;

  const SkillGroupCard({
    required this.skillGroup,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(skillGroup.icon, size: 48),
            SizedBox(height: 8),
            Text(skillGroup.name, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
