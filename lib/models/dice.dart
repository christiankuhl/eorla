import 'package:eorla/main.dart';
import 'package:flutter/material.dart';
import 'dart:math';

enum DiceDisplayMode { text, colored, fancy }

class Dice {
  final int sides;
  int result = -999999; // Default nonsensical, non-null value
  Color? fancyFill;
  Color? fancyBorder;
  final Color fallbackFancyFill = const Color.fromARGB(255, 29, 27, 32);
  final Color fallbackFancyBorder = const Color.fromARGB(255, 126, 118, 139);

  factory Dice.create(int sides, {Color? fill, Color? border}) {
    switch (sides) {
      case 20:
        return D20Dice(fill: fill, border: border);
      case 6:
        return D6Dice(fill: fill, border: border);
      case 3:
        return D3Dice(fill: fill, border: border);
      default:
        return Dice(sides, fill: fill, border: border);
    }
  }

  Dice(this.sides, {Color? fill, Color? border});

  int roll([Random? rng]) {
    rng ??= Random();
    result = rng.nextInt(sides) + 1;
    return result;
  }

  Widget fancyDisplay(BuildContext context) {
    return coloredDisplay(context);
  }

  Widget coloredDisplay(BuildContext context) {
    return textDisplay(context);
  }

  Widget textDisplay(BuildContext context) {
    if (result == -999999) {
      return Text("[X]");
    } else {
      return Text("[$result]");
    }
  }

  Widget displayWidget(
    BuildContext context, [
    DiceDisplayMode displayMode = DiceDisplayMode.text,
  ]) {
    switch (displayMode) {
      case DiceDisplayMode.fancy:
        return fancyDisplay(context);
      case DiceDisplayMode.colored:
        return coloredDisplay(context);
      case DiceDisplayMode.text:
        return textDisplay(context);
    }
  }
}

class D20Dice extends Dice {
  D20Dice({Color? fill, Color? border}) : super(20, fill: fill, border: border);

  @override
  Widget fancyDisplay(BuildContext context, {Gradient? gradient}) {
    fancyFill ??= Theme.of(context).diceBackground;
    fancyFill ??= fallbackFancyFill;

    fancyBorder ??= Theme.of(context).diceBorder;
    fancyBorder ??= fallbackFancyBorder;

    return SizedBox(
      width: 40,
      height: 40,
      child: CustomPaint(
        painter: PolygonPainter(
          sides: 6,
          fillColor: fancyFill!,
          borderColor: fancyBorder!,
          rotation: -pi / 6,
          borderGradient: gradient,
        ),
        child: Center(
          child: Text(
            result == -999999 ? "?" : "$result",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class D20DiceCritical extends D20Dice {
  @override
  Widget fancyDisplay(BuildContext context, {Gradient? gradient}) {
    return super.fancyDisplay(
      context,
      gradient: Theme.of(context).diceCriticalCheckGradient,
    );
  }
}
class D20DiceBotch extends D20Dice {
  @override
  Widget fancyDisplay(BuildContext context, {Gradient? gradient}) {
    return super.fancyDisplay(
      context,
      gradient: Theme.of(context).diceBotchCheckGradient,
    );
  }
}

class D6Dice extends Dice {
  D6Dice({Color? fill, Color? border}) : super(6, fill: fill, border: border);

  @override
  Widget fancyDisplay(BuildContext context) {
    fancyFill ??= Theme.of(context).diceBackground;
    fancyFill ??= fallbackFancyFill;

    fancyBorder ??= Theme.of(context).diceBorder;
    fancyBorder ??= fallbackFancyBorder;

    return SizedBox(
      width: 40,
      height: 40,
      child: CustomPaint(
        painter: PolygonPainter(
          sides: 4,
          fillColor: fancyFill!,
          borderColor: fancyBorder!,
          rotation: pi / 4,
        ),
        child: Center(
          child: Text(
            result == -999999 ? "?" : "$result",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class D3Dice extends Dice {
  D3Dice({Color? fill, Color? border}) : super(3, fill: fill, border: border);

  @override
  Widget fancyDisplay(BuildContext context) {
    fancyFill ??= Theme.of(context).diceBackground;
    fancyFill ??= fallbackFancyFill;

    fancyBorder ??= Theme.of(context).diceBorder;
    fancyBorder ??= fallbackFancyBorder;

    return SizedBox(
      width: 40,
      height: 40,
      child: CustomPaint(
        painter: PolygonPainter(
          sides: 3,
          fillColor: fancyFill!,
          borderColor: fancyBorder!,
          rotation: 0,
        ),
        child: Center(
          child: Text(
            result == -999999 ? "?" : "$result",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class PolygonPainter extends CustomPainter {
  final int sides;
  final Color fillColor;
  final Color borderColor;
  final double rotation; // in radians
  final Gradient? borderGradient;

  PolygonPainter({
    required this.sides,
    required this.fillColor,
    required this.borderColor,
    this.rotation = 0,
    this.borderGradient,
  }) : assert(sides >= 3);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    // 1. Find the min/max y-coordinates for the polygon at unit radius
    double minY = double.infinity;
    double maxY = double.negativeInfinity;
    for (int i = 0; i < sides; i++) {
      final angle = (2 * pi / sides) * i + rotation - pi / 2;
      final y = sin(angle);
      if (y < minY) minY = y;
      if (y > maxY) maxY = y;
    }
    final double polyHeight = maxY - minY;

    // 2. Scale so that the polygon's height matches the container's height
    final double radius = size.height / polyHeight;

    // 3. Build the path
    final path = Path();
    for (int i = 0; i < sides; i++) {
      final angle = (2 * pi / sides) * i + rotation - pi / 2;
      final x = centerX + radius * cos(angle);
      final y = centerY + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // Draw fill
    canvas.drawPath(path, paint);

    // Draw border with gradient if provided
    Paint borderPaint;
    if (borderGradient != null) {
      borderPaint = Paint()
        ..shader = borderGradient!.createShader(
          Rect.fromLTWH(0, 0, size.width, size.height),
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
    } else {
      borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
    }

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
