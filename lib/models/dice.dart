import 'package:eorla/main.dart';
import 'package:eorla/models/rules.dart' show DisplayMode;
import 'package:flutter/material.dart';
import 'dart:math';

class Dice {
  final int sides;
  int result = -999999; // Default nonsensical, non-null value
  Color? fancyFill;
  Color? fancyBorder;
  final Color fallbackFancyFill = const Color.fromARGB(255, 29, 27, 32);
  final Color fallbackFancyBorder = const Color.fromARGB(255, 126, 118, 139);
  final double size;

  factory Dice.create(
    int sides, {
    Color? fill,
    Color? border,
    double size = 40,
  }) {
    switch (sides) {
      case 20:
        return D20Dice(fill: fill, border: border, size: size);
      case 6:
        return D6Dice(fill: fill, border: border, size: size);
      case 3:
        return D3Dice(fill: fill, border: border, size: size);
      default:
        return Dice(sides, fill: fill, border: border, size: size);
    }
  }

  Dice(this.sides, {Color? fill, Color? border, this.size = 40});

  int roll([Random? rng]) {
    rng ??= Random();
    result = rng.nextInt(sides) + 1;
    return result;
  }

  /// Override this to allow extra widgets in dice corners.
  Widget fancyDisplay(
    BuildContext context, {
    Gradient? gradient,
    double? drawSize,
    Widget? topRight,
    Widget? bottomRight,
  }) {
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
    BuildContext context, {
    DisplayMode displayMode = DisplayMode.text,
    Gradient? gradient,
    double? drawSize,
    Widget? topRight,
    Widget? bottomRight,
  }) {
    switch (displayMode) {
      case DisplayMode.fancy:
        return fancyDisplay(
          context,
          gradient: gradient,
          drawSize: drawSize,
          topRight: topRight,
          bottomRight: bottomRight,
        );
      case DisplayMode.colored:
        return Wrap(
          spacing: 8,
          children: [
            coloredDisplay(context),
            if (topRight != null) topRight,
            if (bottomRight != null) bottomRight,
          ],
        );
      case DisplayMode.text:
        return Wrap(
          spacing: 8,
          children: [
            textDisplay(context),
            if (topRight != null) topRight,
            if (bottomRight != null) bottomRight,
          ],
        );
    }
  }
}

class D20Dice extends Dice {
  D20Dice({Color? fill, Color? border, double size = 40})
    : super(20, fill: fill, border: border, size: size);

  @override
  Widget fancyDisplay(
    BuildContext context, {
    Gradient? gradient,
    double? drawSize,
    Widget? topRight,
    Widget? bottomRight,
  }) {
    fancyFill ??= Theme.of(context).diceBackground;
    fancyFill ??= fallbackFancyFill;

    fancyBorder ??= Theme.of(context).diceBorder;
    fancyBorder ??= fallbackFancyBorder;

    final double effectiveSize = drawSize ?? size;

    return Stack(
      clipBehavior: Clip.none, // allow children to paint outside
      children: [
        SizedBox(
          width: effectiveSize,
          height: effectiveSize,
          child: CustomPaint(
            painter: PolygonPainter(
              sides: 6,
              fillColor: fancyFill ?? Colors.grey,
              borderColor: fancyBorder ?? Colors.black,
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
        ),
        // Overlay widgets outside the hexagon bounds
        if (topRight != null)
          Positioned(
            top: -5, // negative to offset outside
            left: effectiveSize + 5,
            child: topRight,
          ),
        if (bottomRight != null)
          Positioned(bottom: -5, left: effectiveSize + 5, child: bottomRight),
      ],
    );
  }
}

class D20DiceCritical extends D20Dice {
  @override
  Widget fancyDisplay(
    BuildContext context, {
    Gradient? gradient,
    double? drawSize,
    Widget? topRight,
    Widget? bottomRight,
  }) {
    return super.fancyDisplay(
      context,
      gradient: Theme.of(context).diceCriticalCheckGradient,
      drawSize: drawSize,
      topRight: topRight,
      bottomRight: bottomRight,
    );
  }

  D20DiceCritical({super.fill, super.border, super.size = 40});

  D20DiceCritical.fromD20(D20Dice base)
    : super(fill: base.fancyFill, border: base.fancyBorder, size: base.size) {
    result = base.result;
  }
}

class D20DiceBotch extends D20Dice {
  @override
  Widget fancyDisplay(
    BuildContext context, {
    Gradient? gradient,
    double? drawSize,
    Widget? topRight,
    Widget? bottomRight,
  }) {
    return super.fancyDisplay(
      context,
      gradient: Theme.of(context).diceBotchCheckGradient,
      drawSize: drawSize,
      topRight: topRight,
      bottomRight: bottomRight,
    );
  }

  D20DiceBotch({super.fill, super.border, super.size = 40});

  D20DiceBotch.fromD20(D20Dice base)
    : super(fill: base.fancyFill, border: base.fancyBorder, size: base.size) {
    result = base.result;
  }
}

class D6Dice extends Dice {
  D6Dice({Color? fill, Color? border, double size = 40})
    : super(6, fill: fill, border: border, size: size);

  @override
  Widget fancyDisplay(
    BuildContext context, {
    Gradient? gradient,
    double? drawSize,
    Widget? topRight,
    Widget? bottomRight,
  }) {
    fancyFill ??= Theme.of(context).diceBackground;
    fancyFill ??= fallbackFancyFill;

    fancyBorder ??= Theme.of(context).diceBorder;
    fancyBorder ??= fallbackFancyBorder;

    final double effectiveSize = drawSize ?? size;

    return Stack(
      clipBehavior: Clip.none, // allow children to paint outside
      children: [
        SizedBox(
          width: effectiveSize,
          height: effectiveSize,
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
        ),
        // Overlay widgets outside the hexagon bounds
        if (topRight != null)
          Positioned(
            top: -5, // negative to offset outside
            left: effectiveSize + 5,
            child: topRight,
          ),
        if (bottomRight != null)
          Positioned(bottom: -5, left: effectiveSize + 5, child: bottomRight),
      ],
    );
  }
}

class D3Dice extends Dice {
  D3Dice({Color? fill, Color? border, double size = 40})
    : super(3, fill: fill, border: border, size: size);

  @override
  Widget fancyDisplay(
    BuildContext context, {
    Gradient? gradient,
    double? drawSize,
    Widget? topRight,
    Widget? bottomRight,
  }) {
    fancyFill ??= Theme.of(context).diceBackground;
    fancyFill ??= fallbackFancyFill;

    fancyBorder ??= Theme.of(context).diceBorder;
    fancyBorder ??= fallbackFancyBorder;

    final double effectiveSize = drawSize ?? size;

    return Stack(
      clipBehavior: Clip.none, // allow children to paint outside
      children: [
        SizedBox(
          width: effectiveSize,
          height: effectiveSize,
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
        ),
        // Overlay widgets outside the hexagon bounds
        if (topRight != null)
          Positioned(
            top: -5, // negative to offset outside
            left: effectiveSize + 5,
            child: topRight,
          ),
        if (bottomRight != null)
          Positioned(bottom: -5, left: effectiveSize + 5, child: bottomRight),
      ],
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
        ..strokeWidth = 3;
    } else {
      borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;
    }

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
