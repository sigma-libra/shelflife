import 'package:flutter/material.dart';

const BLACK_BROWN = Color.fromRGBO(43, 23, 25, 1.0);
const SHELF_BROWN = Color.fromRGBO(211, 160, 103, 1);
const SHELF_TOP_BROWN = Color.fromRGBO(224, 193, 149, 1);
const JAR_YELLOW = Color.fromRGBO(249, 222, 45, 1);
const JAR_RED = Color.fromRGBO(248, 64, 56, 1);
const JAR_BLUE = Color.fromRGBO(153, 209, 226, 1);
const JAR_GREEN = Color.fromRGBO(196, 217, 160, 1);

// Shelf-life state, green through orange to red as the time runs out, the way
// a phone battery reads. Drawn only as the contents of the jar gauge, never as
// a surface or as text. The gauge's own BLACK_BROWN outline separates it from
// SHELF_TOP_BROWN, so these fills are free to be vivid rather than dark enough
// to clear 3:1 on their own.
const LIFE_FULL = Color.fromRGBO(58, 130, 26, 1);
const LIFE_LOW = Color.fromRGBO(226, 124, 16, 1);
const LIFE_DUE = Color.fromRGBO(240, 48, 31, 1);

// The overdue jar is empty, so its outline is the only signal and has to hold
// its own against the header: 3.88:1.
const LIFE_OVERDUE = Color.fromRGBO(180, 32, 15, 1);

/// Legible label colour for an arbitrary user-chosen tag colour.
///
/// Tag colours come from a picker and can be anything, so neither a fixed dark
/// nor a fixed light label works: BLACK_BROWN on a black tag is 1.24:1 and
/// vanishes. This measures both candidates and returns whichever contrasts
/// more, which keeps every swatch in the picker above 4.5:1.
Color labelOn(Color background) {
  final backgroundLuminance = background.computeLuminance();
  final againstWhite = 1.05 / (backgroundLuminance + 0.05);
  final againstDark = (backgroundLuminance + 0.05) / (BLACK_BROWN.computeLuminance() + 0.05);
  return againstWhite > againstDark ? Colors.white : BLACK_BROWN;
}
