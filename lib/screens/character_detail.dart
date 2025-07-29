import 'package:flutter/material.dart';
import '../models/character.dart';
import '../models/skill_groups.dart';
import '../widgets/widget_helpers.dart';
import 'character_selection.dart';
import 'settings.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailScreen({required this.character, super.key});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  bool isEditMode = false;
  Widget profileTab(Character c) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: c.avatar.image,
            radius: 60,
            child: c.avatar.image == null ? Icon(Icons.person, size: 72) : null,
          ),
          SizedBox(height: 16),
          Text('Profilinformationen folgen ...'),
        ],
      ),
    );
  }

  Widget attributesTab(Character c) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Eigenschaften',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          modifierRow('Mut (MU)', c.mu, null, null, active: isEditMode),
          modifierRow('Klugheit (KL)', c.kl, null, null, active: isEditMode),
          modifierRow('Intuition (IN)', c.in_, null, null, active: isEditMode),
          modifierRow('Charisma (CH)', c.ch, null, null, active: isEditMode),
          modifierRow(
            'Fingerfertigkeit (FF)',
            c.ff,
            null,
            null,
            active: isEditMode,
          ),
          modifierRow('Gewandheit (GE)', c.ge, null, null, active: isEditMode),
          modifierRow(
            'Konstitution (KO)',
            c.ko,
            null,
            null,
            active: isEditMode,
          ),
          modifierRow('Körperkraft (KK)', c.kk, null, null, active: isEditMode),
          modifierRow(
            'Lebensenergie (LE)',
            c.lp,
            () => setState(() {
              if (c.lp < c.getHealthMax()) c.lp++;
              if (c.state.schmerz == painLevel(c) + 1) {
                c.state.schmerz = painLevel(c);
              }
            }),
            () => setState(() {
              if (c.lp > 0) c.lp--;
              if (c.state.schmerz < painLevel(c)) {
                c.state.schmerz = painLevel(c);
              }
            }),
            active: !isEditMode,
          ),
          SizedBox(height: 16),
          Text(
            'Zustände',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          modifierRow(
            'Belastung',
            roman(c.state.belastung),
            () => setState(
              () => c.state.belastung = (c.state.belastung + 1).clamp(0, 4),
            ),
            () => setState(
              () => c.state.belastung = (c.state.belastung - 1).clamp(0, 4),
            ),
            active: !isEditMode,
          ),
          modifierRow(
            'Betäubung',
            roman(c.state.betaeubung),
            () => setState(
              () => c.state.betaeubung = (c.state.betaeubung + 1).clamp(0, 4),
            ),
            () => setState(
              () => c.state.betaeubung = (c.state.betaeubung - 1).clamp(0, 4),
            ),
            active: !isEditMode,
          ),
          modifierRow(
            'Entrückung',
            roman(c.state.entrueckung),
            () => setState(
              () => c.state.entrueckung = (c.state.entrueckung + 1).clamp(0, 4),
            ),
            () => setState(
              () => c.state.entrueckung = (c.state.entrueckung - 1).clamp(0, 4),
            ),
            active: !isEditMode,
          ),
          modifierRow(
            'Furcht',
            roman(c.state.furcht),
            () => setState(
              () => c.state.furcht = (c.state.furcht + 1).clamp(0, 4),
            ),
            () => setState(
              () => c.state.furcht = (c.state.furcht - 1).clamp(0, 4),
            ),
            active: !isEditMode,
          ),
          modifierRow(
            'Paralyse',
            roman(c.state.paralyse),
            () => setState(
              () => c.state.paralyse = (c.state.paralyse + 1).clamp(0, 4),
            ),
            () => setState(
              () => c.state.paralyse = (c.state.paralyse - 1).clamp(0, 4),
            ),
            active: !isEditMode,
          ),
          modifierRow(
            'Schmerz',
            roman(c.state.schmerz),
            () => setState(
              () => c.state.schmerz = (c.state.schmerz + 1).clamp(0, 4),
            ),
            () => setState(() {
              if (c.state.schmerz > painLevel(c)) c.state.schmerz--;
            }),
            active: !isEditMode,
          ),
          modifierRow(
            'Verwirrung',
            roman(c.state.verwirrung),
            () => setState(
              () => c.state.verwirrung = (c.state.verwirrung + 1).clamp(0, 4),
            ),
            () => setState(
              () => c.state.verwirrung = (c.state.verwirrung - 1).clamp(0, 4),
            ),
            active: !isEditMode,
          ),
        ],
      ),
    );
  }

  Widget skillTab(Character c) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'Talente'),
              Tab(text: 'Kampftechniken'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ListView(
                  padding: EdgeInsets.all(16),
                  children: skillGroups.entries.map((entry) {
                    return ExpansionTile(
                      title: Text(entry.key.name),
                      children: entry.value.map((skill) {
                        final value = c.talents![skill] ?? 0;
                        return modifierRow(
                          skill.name,
                          value,
                          () => setState(() => c.talents![skill] = value + 1),
                          () => setState(
                            () => c.talents![skill] = value > 0 ? value - 1 : 0,
                          ),
                          active: isEditMode,
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
                Center(child: Text('Kampftechniken folgen ...')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget inventoryTab(Character c) {
    return Center(child: Text('Inventar folgt ...'));
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.character;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(c.name),
          centerTitle: true,
          actions: [
            actionButton(Icons.people_alt, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CharacterSelectionScreen()),
              );
            }, true),
            actionButton(Icons.settings, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsScreen()),
              );
            }, true),
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person), text: 'Profil'),
              Tab(icon: Icon(Icons.bar_chart), text: 'Eigenschaften'),
              Tab(icon: Icon(Icons.auto_fix_high), text: 'Fertigkeiten'),
              Tab(icon: Icon(Symbols.money_bag), text: 'Besitz'),
            ],
            labelStyle: TextStyle(fontSize: 11),
          ),
        ),
        body: TabBarView(
          children: [
            profileTab(c),
            attributesTab(c),
            skillTab(c),
            inventoryTab(c),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() => isEditMode = !isEditMode);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isEditMode
                      ? 'Bearbeitungsmodus aktiviert'
                      : 'Änderungen gespeichert',
                ),
                duration: Duration(seconds: 2),
              ),
            );
          },
          tooltip: isEditMode ? 'Speichern' : 'Bearbeiten',
          child: Icon(isEditMode ? Icons.check : Icons.edit),
        ),
      ),
    );
  }
}

