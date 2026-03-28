import 'package:flutter/material.dart';

// ──────────────────────────────────────────────────────────────────────────────
// SHAPE / RADIUS TOKENS
// ──────────────────────────────────────────────────────────────────────────────

class AppRadius {
  AppRadius._();

  static const double xs = 6.0;
  static const double sm = 8.0;
  static const double md = 10.0;
  static const double lg = 14.0; // cards, CTAs
  static const double xl = 20.0; // bottom sheets
  static const double pill = 30.0; // chips, pills
  static const double circle = 999.0;

  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius chipRadius = BorderRadius.all(
    Radius.circular(pill),
  );
  static const BorderRadius inputRadius = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius iconRadius = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius sheetRadius = BorderRadius.vertical(
    top: Radius.circular(xl),
  );
}
