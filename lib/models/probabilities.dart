import 'dart:math';
import 'rules.dart';

class SkillRollProbability {
  SkillRoll skillRoll;

  SkillRollProbability(this.skillRoll);

  double success() {
    List<int> tgt = [
      skillRoll.tgtValue1.value,
      skillRoll.tgtValue2.value,
      skillRoll.tgtValue3.value,
    ];
    if (tgt.any((e) => e < 1)) {
      return 0.0;
    }
    double ps = prob(tgt, skillRoll.talentValue, 2);
    double pFailDespiteCrit =
        0.0025 *
        [
          for (int t in tgt)
            20.0 - min((t + skillRoll.talentValue).toDouble(), 20.0),
        ].fold(0.0, (s, x) => s + x);
    double pBotchDespiteSuccess = _countBotchSuccesses() / 8000.0;
    return ps + pFailDespiteCrit - pBotchDespiteSuccess;
  }

  int _countBotchSuccesses() {
    int count = 0;
    bool doomSuccess =
        skillRoll
            .roll(random: Deterministic([20, 20, 20]), ignoreBotch: true)
            .quality
            .type ==
        RollEvent.success;
    for (int idx = 0; idx < 3; idx++) {
      var rolls = [20, 20, 20];
      for (int roll = 1; roll <= 20; roll++) {
        rolls[idx] = roll;
        SkillRollResult result = skillRoll.roll(
          random: Deterministic(rolls),
          ignoreBotch: true,
        );
        if (result.quality.type == RollEvent.success) {
          count += 1;
        }
      }
    }
    if (doomSuccess) {
      count -= 2;
    }
    return count;
  }

  double expectedQS() {
    // Brute force for now. It's 8000 iterations of a very simple function, it'll be fine.
    if ([
      skillRoll.tgtValue1,
      skillRoll.tgtValue2,
      skillRoll.tgtValue3,
    ].any((t) => t.value < 1)) {
      return 0.0;
    }
    double exp = 0.0;
    for (int roll1 = 1; roll1 <= 20; roll1++) {
      for (int roll2 = 1; roll2 <= 20; roll2++) {
        for (int roll3 = 1; roll3 <= 20; roll3++) {
          SkillRollResult result = skillRoll.roll(
            random: Deterministic([roll1, roll2, roll3]),
          );
          exp += result.quality.qs.toDouble();
        }
      }
    }
    return exp / 8000.0;
  }
}

double prob(List<int> tgt, int fw, int remaining) {
  if (tgt.any((t) => t < 1) || fw < 0) {
    return 0.0;
  }
  if (remaining == 0) {
    return min((tgt[2] + fw).toDouble(), 20.0) / 20.0;
  } else {
    return [
          for (int t = 1; t <= fw; t++)
            probExact(tgt[2 - remaining] + t) *
                prob(tgt, fw - t, remaining - 1),
        ].fold(0.0, (s, x) => s + x) +
        min(tgt[2 - remaining].toDouble(), 20.0) /
            20.0 *
            prob(tgt, fw, remaining - 1);
  }
}

// Probability to hit exactly [tgt] with a d20
double probExact(int tgt) {
  if (tgt > 20 || tgt < 1) {
    return 0.0;
  } else {
    return 0.05;
  }
}

double attributeRollSuccess(int tgtValue) {
  if (tgtValue < 1) {
    return 0.0;
  }
  return (min(tgtValue.toDouble(), 20.0) - 1.0) / 20.0 +
      (tgtValue >= 20 ? 19.0 / 400.0 : 0.0);
}

class Deterministic implements Random {
  List<int> future;
  Deterministic(this.future) {
    future = future.reversed.map((n) => n - 1).toList();
  }

  @override
  int nextInt(int max) {
    return future.removeLast();
  }

  @override
  bool nextBool() {
    throw UnimplementedError();
  }

  @override
  double nextDouble() {
    throw UnimplementedError();
  }
}
