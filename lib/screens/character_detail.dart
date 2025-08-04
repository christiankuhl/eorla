import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import '../managers/character_manager.dart';
import '../models/character.dart';
import '../models/skill_groups.dart';
import '../models/upgrades.dart';
import '../models/attributes.dart';
import '../widgets/widget_helpers.dart';
import 'character_selection.dart';
import 'settings.dart';

class CharacterDetailScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailScreen({required this.character, super.key});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  bool isEditMode = false;
  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(top: 24, bottom: 8),
    child: Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );

  Widget _infoRow(String? label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          SizedBox(
            width: 140,
            child: Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          ),
        Expanded(child: Text(value)),
      ],
    ),
  );

  Widget profileTab(Character c) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            CircleAvatar(
              backgroundImage: c.avatar.image,
              radius: 60,
              child: c.avatar.image == null
                  ? Icon(Icons.person, size: 72)
                  : null,
            ),
            SizedBox(height: 12),
            Text(c.name, style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 4),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 320),
              child: Text(
                '${c.gender} • ${c.raceVariant == "" ? c.race : '${c.race} (${c.raceVariant})'}',
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(height: 2),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 320),
              child: Text(
                '${c.culture} • ${c.profession}',
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(height: 2),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 320),
              child: Text(
                '${c.experiencelevel} • ${c.totalAP} AP / ${c.ap} AP verfügbar',
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () {
                    _addAP(c);
                  },
                  child: Text('AP HINZUFÜGEN'),
                ),
                OutlinedButton(onPressed: () {}, child: Text('EXPORTIEREN')),
              ],
            ),

            _sectionTitle('Persönliche Daten'),
            _infoRow('Familie', c.family),
            _infoRow('Geburtsort', c.placeOfBirth),
            _infoRow('Geburtsdatum', c.dateOfBirth),
            _infoRow('Alter', c.age),
            _infoRow('Haarfarbe', c.hairColour),
            _infoRow('Augenfarbe', c.eyeColour),
            _infoRow('Körpergröße', c.size),
            _infoRow('Gewicht', c.weight),
            _infoRow('Titel', c.title),
            _infoRow('Sozialstatus', c.socialStatus),
            _infoRow('Charakteristika', c.characteristics),
            _infoRow('Sonstiges', c.otherInfo),

            _sectionTitle('Vorteile'),
            _infoRow(
              null,
              (c.advantages ?? []).map((a) => a.toString()).join(", "),
            ),

            _sectionTitle('Nachteile'),
            _infoRow(
              null,
              (c.disadvantages ?? []).map((a) => a.toString()).join(", "),
            ),
          ],
        ),
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
          modifierRow(
            'Mut (MU)',
            c.mu,
            upgradeHandler(Upgrade.attribute, Attribute.mut.id, c, setState),
            upgradeHandler(
              Upgrade.attribute,
              Attribute.mut.id,
              c,
              setState,
              sign: Sign.decrement,
            ),
            active: isEditMode,
          ),
          modifierRow(
            'Klugheit (KL)',
            c.kl,
            upgradeHandler(
              Upgrade.attribute,
              Attribute.klugheit.id,
              c,
              setState,
            ),
            upgradeHandler(
              Upgrade.attribute,
              Attribute.klugheit.id,
              c,
              setState,
              sign: Sign.decrement,
            ),
            active: isEditMode,
          ),
          modifierRow(
            'Intuition (IN)',
            c.in_,
            upgradeHandler(
              Upgrade.attribute,
              Attribute.intuition.id,
              c,
              setState,
            ),
            upgradeHandler(
              Upgrade.attribute,
              Attribute.intuition.id,
              c,
              setState,
              sign: Sign.decrement,
            ),

            active: isEditMode,
          ),
          modifierRow(
            'Charisma (CH)',
            c.ch,
            upgradeHandler(
              Upgrade.attribute,
              Attribute.charisma.id,
              c,
              setState,
            ),
            upgradeHandler(
              Upgrade.attribute,
              Attribute.charisma.id,
              c,
              setState,
              sign: Sign.decrement,
            ),
            active: isEditMode,
          ),
          modifierRow(
            'Fingerfertigkeit (FF)',
            c.ff,
            upgradeHandler(
              Upgrade.attribute,
              Attribute.fingerfertigkeit.id,
              c,
              setState,
            ),
            upgradeHandler(
              Upgrade.attribute,
              Attribute.fingerfertigkeit.id,
              c,
              setState,
              sign: Sign.decrement,
            ),
            active: isEditMode,
          ),
          modifierRow(
            'Gewandheit (GE)',
            c.ge,
            upgradeHandler(
              Upgrade.attribute,
              Attribute.gewandtheit.id,
              c,
              setState,
            ),
            upgradeHandler(
              Upgrade.attribute,
              Attribute.gewandtheit.id,
              c,
              setState,
              sign: Sign.decrement,
            ),
            active: isEditMode,
          ),
          modifierRow(
            'Konstitution (KO)',
            c.ko,
            upgradeHandler(
              Upgrade.attribute,
              Attribute.konstitution.id,
              c,
              setState,
            ),
            upgradeHandler(
              Upgrade.attribute,
              Attribute.konstitution.id,
              c,
              setState,
              sign: Sign.decrement,
            ),

            active: isEditMode,
          ),
          modifierRow(
            'Körperkraft (KK)',
            c.kk,
            upgradeHandler(
              Upgrade.attribute,
              Attribute.koerperkraft.id,
              c,
              setState,
            ),
            upgradeHandler(
              Upgrade.attribute,
              Attribute.koerperkraft.id,
              c,
              setState,
              sign: Sign.decrement,
            ),
            active: isEditMode,
          ),
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
                          upgradeHandler(Upgrade.skill, skill.id, c, setState),
                          upgradeHandler(
                            Upgrade.skill,
                            skill.id,
                            c,
                            setState,
                            sign: Sign.decrement,
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

  Widget _editMenu(Character c) {
    return SpeedDial(
      icon: Icons.edit,
      activeIcon: Icons.check,
      onClose: () async {
        setState(() {
          isEditMode = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Änderungen gespeichert'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      onOpen: () {
        setState(() {
          isEditMode = true;
        });
      },
      renderOverlay: false,
      closeManually: true,
      children: [
        SpeedDialChild(onTap: () => _addAP(c), child: Icon(Icons.add_circle)),
        SpeedDialChild(
          onTap: c.undoStack!.isNotEmpty
              ? () => setState(() {
                  c.undo();
                })
              : null,
          child: Icon(Icons.undo),
        ),
      ],
    );
  }

  Widget _apBadge(Character c) {
    return Positioned(
      right: 16,
      top: 16,
      child: AnimatedOpacity(
        opacity: isEditMode ? 1.0 : 0.0,
        duration: Duration(milliseconds: 200),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.flash_on, size: 18, color: Colors.amber),
              SizedBox(width: 6),
              Text(
                '${c.ap} AP',
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addAP(Character c) async {
    CharacterManager manager = Provider.of(context, listen: false);
    final addedAp = await showDialog<int>(
      context: context,
      builder: (_) => const AddAPDialog(),
    );
    if (!mounted) {
      return;
    }
    if (addedAp != null) {
      setState(() {
        c.ap += addedAp;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$addedAp AP hinzugefügt')));
      await manager.saveCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.character;

    return SafeArea(
      child: DefaultTabController(
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
          body: Stack(
            children: [
              TabBarView(
                children: [
                  profileTab(c),
                  attributesTab(c),
                  skillTab(c),
                  inventoryTab(c),
                ],
              ),
              _apBadge(c),
            ],
          ),
          floatingActionButton: _editMenu(c),
        ),
      ),
    );
  }
}

class AddAPDialog extends StatefulWidget {
  const AddAPDialog({super.key});

  @override
  State<AddAPDialog> createState() => _AddAPDialogState();
}

class _AddAPDialogState extends State<AddAPDialog> {
  final TextEditingController _controller = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('AP hinzufügen'),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'AP',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // cancel
          child: Text('Abbrechen'),
        ),
        ElevatedButton(
          onPressed: () {
            final value = int.tryParse(_controller.text);
            Navigator.of(context).pop(value ?? 0);
          },
          child: Text('Hinzufügen'),
        ),
      ],
    );
  }
}
