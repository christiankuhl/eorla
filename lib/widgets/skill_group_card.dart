import 'package:flutter/material.dart';
import '../widgets/widget_helpers.dart';
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
    return mainScreenPanel(skillGroup.name, skillGroup.icon, onTap);
  }
}
