import 'package:dsaroll/utils/character_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/skill_group_selection_screen.dart';
import 'managers/character_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final characters = await CharacterStorage.loadCharacters();
  runApp(
    ChangeNotifierProvider(
      create: (_) => CharacterManager(characters: characters),
      child: TalentRollerApp(),
    ),
  );
}

class TalentRollerApp extends StatelessWidget {
  const TalentRollerApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talent Roller',
      theme: ThemeData.dark(),
      home: SkillGroupSelectionScreen(),
    );
  }
}
