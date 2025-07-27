import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../managers/settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<AppSettings>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Einstellungen')),
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
          SwitchListTile(
            title: const Text('Animationen'),
            subtitle: const Text('Würfelanimationen verwenden'),
            value: settings.useAnimations,
            onChanged: (value) {
              settings.toggleAnimations();
            },
            secondary: const Icon(Icons.animation),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text('Kritische Erfolge'),
                subtitle: const Text(
                  'Tabelle für kritische Kampferfolge verwenden',
                ),
                value: settings.useCritTable,
                onChanged: (value) {
                  settings.toggleCritTable();
                },
                secondary: const Icon(Icons.military_tech),
              ),
              if (settings.useCritTable)
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: SwitchListTile(
                    title: const Text('Fokusregeln verwenden'),
                    subtitle: const Text(
                      'Fokusregeln für kritische Kampferfolge verwenden',
                    ),
                    value: settings.useFocusRulesCrit,
                    onChanged: (value) {
                      settings.toggleFocusRulesCrit();
                    },
                    secondary: const Icon(Icons.filter_center_focus),
                  ),
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text('Patzertabelle'),
                subtitle: const Text('Patzertabelle verwenden'),
                value: settings.useBotchTable,
                onChanged: (value) {
                  settings.toggleBotchTable();
                },
                secondary: const Icon(Icons.report_problem),
              ),
              if (settings.useBotchTable)
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: SwitchListTile(
                    title: const Text('Fokusregeln verwenden'),
                    subtitle: const Text('Fokusregeln für Patzer verwenden'),
                    value: settings.useFocusRulesBotch,
                    onChanged: (value) {
                      settings.toggleFocusRulesBotch();
                    },
                    secondary: const Icon(Icons.filter_center_focus),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
