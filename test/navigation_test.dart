import 'package:eorla/models/skill.dart';
import 'package:eorla/models/skill_groups.dart';
import 'package:eorla/screens/skill_roll.dart';
import 'package:video_player_platform_interface/video_player_platform_interface.dart';
import 'package:eorla/models/attributes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:eorla/screens/attribute_roll.dart';
import 'package:eorla/screens/dice_rolls.dart';
import 'rules_test.dart';
import 'package:eorla/main.dart';

void main() {
  setUpAll(() {
    VideoPlayerPlatform.instance = FakeVideoPlayerPlatform();
  });
  testWidgets('Attribute roll button triggers dice roll transition', (
    WidgetTester tester,
  ) async {
    await diceTransitionAndBack(
      AttributeRollScreen(
        attribute: Attribute.charisma,
        character: durchschnittsdoedel(),
      ),
      const Key("attribute_roll_button"),
      tester,
    );
  });

  testWidgets('Skill roll button triggers dice roll transition', (
    WidgetTester tester,
  ) async {
    await diceTransitionAndBack(
      RollScreen(
        skillOrSpell: SkillWrapper(Skill.betoeren),
        character: durchschnittsdoedel(),
      ),
      const Key("skill_roll_button"),
      tester,
    );
  });

  testWidgets("MainScreen shows proper options", (WidgetTester tester) async {
    await tester.pumpWidget(app([durchschnittsdoedel()]));
    for (var grp in SkillGroup.values) {
      expect(find.text(grp.name), findsOneWidget);
    }
    expect(find.text("Kampf"), findsOneWidget);
    expect(find.text("Eigenschaften"), findsOneWidget);
    expect(find.text("Magie"), findsNothing);
  });
}

Future<void> diceTransitionAndBack(
  Widget testScreen,
  Key buttonKey,
  WidgetTester tester,
) async {
  await tester.pumpWidget(
    provideContext([durchschnittsdoedel()], MaterialApp(home: testScreen)),
  );
  expect(find.byKey(buttonKey), findsOneWidget);
  await tester.ensureVisible(find.byKey(buttonKey));
  await tester.tap(find.byKey(buttonKey));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
  expect(find.byType(DiceRollTransition), findsOneWidget);
  await tester.pumpAndSettle();
  expect(find.byKey(buttonKey), findsOneWidget);
}

class FakeVideoPlayerPlatform extends VideoPlayerPlatform {
  @override
  Future<void> init() async {}

  @override
  Future<int> create(DataSource dataSource) async => 1;

  @override
  Future<void> dispose(int textureId) async {}

  @override
  Future<void> play(int textureId) async {}

  @override
  Future<void> pause(int textureId) async {}

  @override
  Future<void> seekTo(int textureId, Duration position) async {}

  @override
  Future<Duration> getPosition(int textureId) async => Duration.zero;

  @override
  Stream<VideoEvent> videoEventsFor(int textureId) =>
      Stream<VideoEvent>.fromIterable([
        VideoEvent(eventType: VideoEventType.initialized),
      ]);

  @override
  Future<void> setLooping(int textureId, bool looping) async {}

  @override
  Future<void> setVolume(int textureId, double volume) async {}

  @override
  Future<void> setPlaybackSpeed(int textureId, double speed) async {}

  @override
  Future<void> setMixWithOthers(bool mixWithOthers) async {}
}
