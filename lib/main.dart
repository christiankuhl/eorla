import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/main_screen.dart';
import 'managers/character_manager.dart';
import 'managers/character_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final characters = await CharacterStorage.loadCharacters();
  runApp(
    ChangeNotifierProvider(
      create: (_) => CharacterManager(characters: characters),
      child: Eorla(),
    ),
  );
}

class Eorla extends StatelessWidget {
  const Eorla({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eorla',
      theme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}

// Extend the dark and light themes with my own colors which I will use for my dice widget
extension DiceThemeColors on ThemeData {
  Color get diceBorder => brightness == Brightness.dark
      ? const Color.fromARGB(255, 126, 118, 139)
      : const Color.fromARGB(255, 29, 27, 32);
  Color get diceBackground => brightness == Brightness.dark
      ? const Color.fromARGB(255, 29, 27, 32)
      : const Color.fromARGB(255, 126, 118, 139);
}
