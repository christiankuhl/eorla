import 'package:flutter/material.dart';
import 'dart:math';
import '../models/rules.dart';
import '../models/audit.dart';
import '../widgets/dice.dart';


class Dice {
  final int sides;
  DiceValue? result;
  DiceDisplay display;

  factory Dice.create(
    int sides, {
    Color? fill,
    Color? border,
    double size = 40,
    DiceValue? value,
    RollEvent? event,
  }) {
    DiceDisplay? display;
    switch (sides) {
      case 20:
        switch (event ?? RollEvent.success) {
          case RollEvent.botch:
            display = D20DisplayBotch(fill: fill, border: border, size: size);
            break;
          case RollEvent.critical:
            display = D20DisplayCritical(fill: fill, border: border, size: size);
            break;
          default:
            display = D20Display(fill: fill, border: border, size: size);
        }
        break;
      case 6:
        display = D6Display(fill: fill, border: border, size: size);
        break;
      case 3:
        display = D3Display(fill: fill, border: border, size: size);
        break;
    }
    display ??= DiceDisplay();
    Dice die = Dice(sides, display);
    die.result = value;
    return die;
  }

  Dice(this.sides, this.display);

  void setDisplay(RollEvent? event, {Color? fill, Color? border, double size = 40}) {
    switch (sides) {
      case 20:
        switch (event ?? RollEvent.success) {
          case RollEvent.botch:
            display = D20DisplayBotch(fill: fill, border: border, size: size);
            break;
          case RollEvent.critical:
            display = D20DisplayCritical(fill: fill, border: border, size: size);
            break;
          default:
            display = D20Display(fill: fill, border: border, size: size);
        }
        break;
      case 6:
        display = D6Display(fill: fill, border: border, size: size);
        break;
      case 3:
        display = D3Display(fill: fill, border: border, size: size);
        break;
    }
  }

  int roll([Random? rng]) {
    rng ??= Random();
    result = DiceValue(rng.nextInt(sides) + 1);
    return result!.value;
  }
}
