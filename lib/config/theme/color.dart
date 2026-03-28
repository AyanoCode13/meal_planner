import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
 
  // ── Core Palette ─────────────────────────────────────────────────────────
  static const Color bg           = Color(0xFFF5F0E8); // warm parchment background
  static const Color surface      = Color(0xFFFDFAF4); // card / input background
  static const Color surface2     = Color(0xFFEDE8DC); // chip / stepper background
  static const Color ink          = Color(0xFF1C1A15); // primary text
  static const Color inkSoft      = Color(0xFF6B6455); // secondary / hint text
  static const Color border       = Color(0xFFDDD8CC); // dividers, borders
 
  // ── Accent (amber-terracotta) ─────────────────────────────────────────────
  static const Color accent       = Color(0xFFC4783A);
  static const Color accentLight  = Color(0xFFF2E0CC);
 
  // ── Green (fresh / success) ───────────────────────────────────────────────
  static const Color green        = Color(0xFF4A7C59);
  static const Color greenLight   = Color(0xFFD4E8D9);
 
  // ── Red (expired / error) ─────────────────────────────────────────────────
  static const Color red          = Color(0xFFC0392B);
  static const Color redLight     = Color(0xFFFAD4CE);
 
  // ── Semantic tints ────────────────────────────────────────────────────────
  static const Color blue         = Color(0xFFD6E4F5);  // info / category
  static const Color purple       = Color(0xFFE8D6F5);  // difficulty / special
  static const Color yellow       = Color(0xFFFFF3CD);  // prep time / warning
 
  // ── On-colours ────────────────────────────────────────────────────────────
  static const Color onAccent     = Colors.white;
  static const Color onGreen      = Colors.white;
  static const Color onRed        = Colors.white;
  static const Color onInk        = Colors.white;
}