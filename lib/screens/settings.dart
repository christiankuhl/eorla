import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettings>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Einstellungen'), 
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Nerd Mode'),
            subtitle: const Text('Statistische Größen anzeigen'),
            value: settings.nerdMode,
            onChanged: (value) {
              settings.toggleNerdMode();
            },
            secondary: const Icon(Icons.psychology),
          ),
        ],
      ),
    );
  }
}
