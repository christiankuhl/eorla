import 'package:flutter/material.dart';
import 'dart:math';

enum DiceDisplayMode { text, colored, fancy }

class Dice {
  final int sides;
  int result = -999999; // Default nonsensical, non-null value
  Color fancyFill;
  Color fancyBorder;

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

  Dice(this.sides, {Color? fill, Color? border})
    : fancyFill = fill ?? const Color.fromARGB(255, 29, 27, 32),
      fancyBorder = border ?? const Color.fromARGB(255, 126, 118, 139);

  int roll([Random? rng]) {
    rng ??= Random();
    result = rng.nextInt(sides) + 1;
    return result;
  }

  Widget fancyDisplay() {
    return coloredDisplay();
  }

  Widget coloredDisplay() {
    return textDisplay();
  }

  Widget textDisplay() {
    if (result == -999999) {
      return Text("[X]");
    } else {
      return Text("[$result]");
    }
  }

  Widget displayWidget([DiceDisplayMode displayMode = DiceDisplayMode.text]) {
    switch (displayMode) {
      case DiceDisplayMode.fancy:
        return fancyDisplay();
      case DiceDisplayMode.colored:
        return coloredDisplay();
      case DiceDisplayMode.text:
        return textDisplay();
    }
  }
}

class D20Dice extends Dice {
  D20Dice({Color? fill, Color? border}) : super(20, fill: fill, border: border);

  @override
  Widget fancyDisplay() {
    return Container(
      width: 40,
      height: 40,
      child: CustomPaint(
        painter: _HexagonPainter(
          fillColor: fancyFill,
          borderColor: fancyBorder,
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

class D6Dice extends Dice {
  D6Dice({Color? fill, Color? border}) : super(6, fill: fill, border: border);

  @override
  Widget fancyDisplay() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: fancyBorder, width: 2),
        color: fancyFill,
      ),
      child: Center(
        child: Text(
          result == -999999 ? "?" : "$result",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class D3Dice extends Dice {
  D3Dice({Color? fill, Color? border}) : super(3, fill: fill, border: border);

  @override
  Widget fancyDisplay() {
    return Container(
      width: 40,
      height: 40,
      child: CustomPaint(
        painter: _TrianglePainter(
          fillColor: fancyFill,
          borderColor: fancyBorder,
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


class _HexagonPainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;

  _HexagonPainter({
    this.fillColor = Colors.white70,
    this.borderColor = Colors.black87,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final double w = size.width;
    final double h = size.height;
    final double r = w / 2;
    final double centerX = w / 2;
    final double centerY = h / 2;

    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (pi / 3) * i - pi / 6;
      final x = centerX + r * cos(angle);
      final y = centerY + r * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TrianglePainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;

  _TrianglePainter({
    this.fillColor = Colors.white70,
    this.borderColor = Colors.black87,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final double w = size.width;
    final double h = size.height;

    final path = Path();
    path.moveTo(w / 2, h * 0.15); // Top vertex
    path.lineTo(w * 0.1, h * 0.85); // Bottom left
    path.lineTo(w * 0.9, h * 0.85); // Bottom right
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
