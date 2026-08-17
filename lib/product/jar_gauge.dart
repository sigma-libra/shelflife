import 'package:flutter/material.dart';
import 'package:shelflife/colors.dart';
import 'package:shelflife/product/product.dart';

enum ShelfLifeState { untracked, full, low, due, overdue }

/// How much life a product has left, resolved for display.
///
/// The window runs from the product's [Product.saveTime] forward by
/// `monthsToReplacement * 30` days, which is the same span the notification
/// is scheduled against, so the jar and the reminder always agree.
class ShelfLife {
  final ShelfLifeState state;

  /// Whole months still remaining. Zero or negative once the window closes.
  final int monthsLeft;

  const ShelfLife._(this.state, this.monthsLeft);

  /// A jar with nothing tracked in it. Used by the empty shelf.
  static const ShelfLife none = ShelfLife._(ShelfLifeState.untracked, 0);

  /// State is read off the months remaining, not off the portion of the window
  /// used up, so a six-month product and a two-year one look the same when
  /// each has a month to go. Urgency is about the calendar, not the ratio.
  factory ShelfLife.of(Product product, {DateTime? now}) {
    final months = product.monthsToReplacement;
    if (months == null || months <= 0) {
      return const ShelfLife._(ShelfLifeState.untracked, 0);
    }

    final windowEnd = DateTime.fromMillisecondsSinceEpoch(product.saveTime).add(Duration(days: months * 30));
    final remainingDays = windowEnd.difference(now ?? DateTime.now()).inDays;
    final monthsLeft = (remainingDays / 30).ceil();

    if (remainingDays <= 0) {
      return ShelfLife._(ShelfLifeState.overdue, monthsLeft);
    }
    if (monthsLeft > 2) {
      return ShelfLife._(ShelfLifeState.full, monthsLeft);
    }
    if (monthsLeft > 1) {
      return ShelfLife._(ShelfLifeState.low, monthsLeft);
    }
    return ShelfLife._(ShelfLifeState.due, monthsLeft);
  }

  Color get color {
    switch (state) {
      case ShelfLifeState.full:
        return LIFE_FULL;
      case ShelfLifeState.low:
        return LIFE_LOW;
      case ShelfLifeState.due:
        return LIFE_DUE;
      case ShelfLifeState.overdue:
        return LIFE_OVERDUE;
      case ShelfLifeState.untracked:
        return BLACK_BROWN;
    }
  }

  /// How full the jar draws, as a portion of its body.
  ///
  /// Stepped rather than continuous, so the level reads the same way a phone
  /// battery does: over six months is full and green, a month or less is a red
  /// sliver, orange between. The exact figure is carried by the card's text.
  double get level {
    switch (state) {
      case ShelfLifeState.full:
        return 1.0;
      case ShelfLifeState.low:
        return 0.5;
      case ShelfLifeState.due:
        return 0.15;
      case ShelfLifeState.overdue:
      case ShelfLifeState.untracked:
        return 0.0;
    }
  }
}

/// A jar that empties as a product's shelf life runs down.
///
/// The launcher icon is a shelf of jars; this is that jar, made to carry
/// state. Fill level and fill colour both track the remaining window, and
/// the card states the same fact in words, so nothing rests on colour alone.
class JarGauge extends StatelessWidget {
  /// Width as a portion of height. Keeps the jar from going oval.
  static const double _aspect = 34 / 42;

  final ShelfLife life;
  final double height;

  /// Draws a red exclamation mark inside the jar. Used by the empty shelf,
  /// where the jar is the illustration rather than a per-product gauge.
  final bool alert;

  const JarGauge({super.key, required this.life, this.height = 42, this.alert = false});

  @override
  Widget build(BuildContext context) {
    // The gauge carries information, so it grows with the system font-size
    // setting rather than shrinking against the text beside it. FittedBox
    // keeps the silhouette square-shouldered whatever the parent slot allows.
    final scaled = MediaQuery.textScalerOf(context).scale(height).clamp(height, height * 1.6);
    return ExcludeSemantics(
      child: SizedBox(
        width: scaled * _aspect,
        height: scaled,
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: 42 * _aspect,
            height: 42,
            child: CustomPaint(painter: _JarPainter(life, alert: alert)),
          ),
        ),
      ),
    );
  }
}

class _JarPainter extends CustomPainter {
  final ShelfLife life;
  final bool alert;

  _JarPainter(this.life, {this.alert = false});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final untracked = life.state == ShelfLifeState.untracked;

    // Proportions are expressed as fractions of the box so the jar scales
    // cleanly with the system font-size setting.
    final lid = RRect.fromLTRBR(w * 0.26, 0, w * 0.74, h * 0.12, Radius.circular(w * 0.05));
    final neck = Rect.fromLTRB(w * 0.34, h * 0.12, w * 0.66, h * 0.20);
    final body = RRect.fromLTRBAndCorners(
      0,
      h * 0.19,
      w,
      h,
      topLeft: Radius.circular(w * 0.22),
      topRight: Radius.circular(w * 0.22),
      bottomLeft: Radius.circular(w * 0.18),
      bottomRight: Radius.circular(w * 0.18),
    );

    final glass = Paint()..color = BLACK_BROWN.withValues(alpha: untracked ? 0.05 : 0.10);
    canvas.drawRRect(body, glass);
    canvas.drawRect(neck, glass);

    // Contents fill the body to the state's step. Overdue draws nothing, so an
    // empty jar and a red one never mean the same thing.
    if (life.level > 0) {
      canvas.save();
      canvas.clipRRect(body);
      final top = h - (h - h * 0.19) * life.level;
      canvas.drawRect(
        Rect.fromLTRB(0, top, w, h),
        Paint()..color = life.color,
      );
      canvas.restore();
    }

    // Overdue is the empty jar, and it draws its own outline in the state
    // colour so it is not merely the absence of contents.
    final outline = untracked
        ? BLACK_BROWN.withValues(alpha: 0.30)
        : life.state == ShelfLifeState.overdue
            ? LIFE_OVERDUE
            : BLACK_BROWN;

    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.06
      ..strokeJoin = StrokeJoin.round
      ..color = outline;

    canvas.drawRect(neck, stroke);
    canvas.drawRRect(body, stroke);
    canvas.drawRRect(lid, Paint()..color = outline);

    if (alert) {
      final mark = Paint()..color = LIFE_DUE;
      canvas.drawRRect(
        RRect.fromLTRBR(w * 0.43, h * 0.34, w * 0.57, h * 0.71, Radius.circular(w * 0.07)),
        mark,
      );
      canvas.drawCircle(Offset(w * 0.5, h * 0.83), w * 0.08, mark);
    }
  }

  @override
  bool shouldRepaint(_JarPainter oldDelegate) => oldDelegate.life.state != life.state || oldDelegate.alert != alert;
}
