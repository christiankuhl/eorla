import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/main_screen.dart';
import 'managers/character_manager.dart';
import 'managers/character_storage.dart';
import 'managers/settings.dart';
import 'models/character.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final characters = await CharacterStorage.loadCharacters();
  runApp(app(characters));
}

MultiProvider app(List<Character> characters) {
  return provideContext(characters, Eorla());
}

MultiProvider provideContext(List<Character> characters, Widget child) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => CharacterManager(characters: characters),
      ),
      ChangeNotifierProvider(create: (_) => AppSettings()),
    ],
    child: child,
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
  Color get diceBackground => brightness == Brightness.dark
      ? const Color.fromARGB(255, 29, 27, 32)
      : const Color.fromARGB(255, 254, 247, 255);
  Color get diceBorder => brightness == Brightness.dark
      ? const Color.fromARGB(255, 126, 118, 139)
      : const Color.fromARGB(255, 113, 111, 115);

  Gradient get diceCriticalCheckGradient => const LinearGradient(
    colors: [
      Color(0xFFFFD700), // Gold
      Color(0xFFFFC300), // Rich gold
      Color(0xFFFFB700), // Deep gold
      Color(0xFFB8860B), // Dark goldenrod
    ],
    stops: [0.0, 0.5, 0.8, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  Gradient get diceBotchCheckGradient => const LinearGradient(
    colors: [
      Color(0xFFB71C1C), // Deep red (hellish)
      Color(0xFFD32F2F), // Stronger red
      Color(0xFF8D6E63), // Muted bronze
      Color(0xFF3E2723), // Dark brown (burnt metal)
    ],
    stops: [0.0, 0.25, 0.6, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
