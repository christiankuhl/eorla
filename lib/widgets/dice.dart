import 'package:flutter/material.dart';
import 'dart:math';
import '../models/audit.dart';
import '../models/rules.dart';
import '../main.dart';

enum DisplayMode { text, colored, fancy }

Widget damageResultsWidget(DamageRollResult result, BuildContext context) {
  return IntrinsicHeight(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: result.dice
              .map(
                (d) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: d.display.displayWidget(
                    d.result,
                    context,
                    displayMode: DisplayMode.fancy,
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}

Widget damageText(DamageRollResult result, BuildContext context) {
  return RichText(
    text: TextSpan(
      style: Theme.of(context).textTheme.bodyMedium,
      children: [
        const TextSpan(text: "Dein Angriff verursacht "),
        TextSpan(
          text: result.combinedResult.toString(),
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const TextSpan(text: " Trefferpunkt(e)."),
      ],
    ),
  );
}

Widget attributeRollResult(AttributeRollResult result, BuildContext context) {
  return IntrinsicHeight(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: result.dice
              .map(
                (d) => Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 40.0),
                  child: d.display.displayWidget(
                    d.result,
                    context,
                    displayMode: DisplayMode.fancy,
                    topRight: Text("≤ ${result.targetValue.value}"),
                    bottomRight:
                        (d.result?.value ?? 20) <= result.targetValue.value
                        ? Icon(Icons.check, color: Colors.green, size: 20.0)
                        : Icon(Icons.close, color: Colors.red, size: 20.0),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}

Widget attributeResultText(AttributeRollResult result, BuildContext context) {
  return Center(
    child: RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.titleMedium,
        children: [
          TextSpan(
            text: result.roll != null ? result.text() : "?",
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

Widget skillRollResultText(SkillRollResult result, BuildContext context) {
  switch (result.quality.type) {
    case RollEvent.success:
      return RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: "Erfolg! (",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            TextSpan(
              text: "QS: ${result.quality.qs}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            TextSpan(
              text: ")",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    case RollEvent.failure:
    case RollEvent.critical:
    case RollEvent.botch:
      return RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: result.text(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
  }
}

Widget skillRollResultWidget(
  List<AttributeRollResult> results,
  BuildContext context,
) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Column(
        children: results
            .map(
              (roll) => Padding(
                padding: const EdgeInsets.only(bottom: 15.0, top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(roll.resultContext ?? "i"),
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: roll.dice[0].display.displayWidget(
                        roll.dice[0].result,
                        context,
                        displayMode: DisplayMode.fancy,
                        topRight: Text("≤ ${roll.targetValue.value}"),
                        bottomRight:
                            (roll.dice[0].result?.value ?? 20) <=
                                roll.targetValue.value
                            ? Icon(Icons.check, color: Colors.green, size: 20.0)
                            : Text(
                                "- ${roll.dice[0].result!.value - roll.targetValue.value}",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
      const SizedBox(height: 24),
    ],
  );
}

class DiceDisplay {
  Color? fancyFill;
  Color? fancyBorder;
  final Color fallbackFancyFill = const Color.fromARGB(255, 29, 27, 32);
  final Color fallbackFancyBorder = const Color.fromARGB(255, 126, 118, 139);
  double size = 40;
  Color? fill;
  Color? border;

  DiceDisplay({this.fill, this.border, this.size = 40});

  Widget fancyDisplay(
    DiceValue? die,
    BuildContext context, {
    Gradient? gradient,
    double? drawSize,
    Widget? topRight,
    Widget? bottomRight,
  }) {
    return coloredDisplay(die, context);
  }

  Widget coloredDisplay(DiceValue? die, BuildContext context) {
    return textDisplay(die, context);
  }

  Widget textDisplay(DiceValue? die, BuildContext context) {
    if (die != null) {
      return Text("[X]");
    } else {
      return Text("[$die]");
    }
  }

  Widget displayWidget(
    DiceValue? die,
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
          die,
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
            coloredDisplay(die, context),
            if (topRight != null) topRight,
            if (bottomRight != null) bottomRight,
          ],
        );
      case DisplayMode.text:
        return Wrap(
          spacing: 8,
          children: [
            textDisplay(die, context),
            if (topRight != null) topRight,
            if (bottomRight != null) bottomRight,
          ],
        );
    }
  }
}

class D20Display extends DiceDisplay {
  D20Display({super.fill, super.border, super.size = 40});

  @override
  Widget fancyDisplay(
    DiceValue? die,
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
                die == null ? "?" : "$die",
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

class D20DisplayCritical extends D20Display {
  @override
  Widget fancyDisplay(
    DiceValue? die,
    BuildContext context, {
    Gradient? gradient,
    double? drawSize,
    Widget? topRight,
    Widget? bottomRight,
  }) {
    return super.fancyDisplay(
      die,
      context,
      gradient: Theme.of(context).diceCriticalCheckGradient,
      drawSize: drawSize,
      topRight: topRight,
      bottomRight: bottomRight,
    );
  }

  D20DisplayCritical({super.fill, super.border, super.size = 40});

  D20DisplayCritical.fromD20(D20Display base)
    : super(fill: base.fancyFill, border: base.fancyBorder, size: base.size);
}

class D20DisplayBotch extends D20Display {
  @override
  Widget fancyDisplay(
    DiceValue? die,
    BuildContext context, {
    Gradient? gradient,
    double? drawSize,
    Widget? topRight,
    Widget? bottomRight,
  }) {
    return super.fancyDisplay(
      die,
      context,
      gradient: Theme.of(context).diceBotchCheckGradient,
      drawSize: drawSize,
      topRight: topRight,
      bottomRight: bottomRight,
    );
  }

  D20DisplayBotch({super.fill, super.border, super.size = 40});

  D20DisplayBotch.fromD20(D20Display base)
    : super(fill: base.fancyFill, border: base.fancyBorder, size: base.size);
}

class D6Display extends DiceDisplay {
  D6Display({super.fill, super.border, super.size = 40});

  @override
  Widget fancyDisplay(
    DiceValue? die,
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
                die == null ? "?" : "$die",
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

class D3Display extends DiceDisplay {
  D3Display({super.fill, super.border, super.size = 40});

  @override
  Widget fancyDisplay(
    DiceValue? die,
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
                die == null ? "?" : "$die",
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
