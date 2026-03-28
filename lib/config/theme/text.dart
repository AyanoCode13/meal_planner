import 'package:flutter/material.dart';

import 'color.dart';


// ──────────────────────────────────────────────────────────────────────────────
// APP TEXT STYLES
// ──────────────────────────────────────────────────────────────────────────────
 
class AppTextStyles {
  AppTextStyles._();
 
  // ── Display / Headings  (Playfair Display) ────────────────────────────────
  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 32,
    fontWeight: FontWeight.w600, 
    color: AppColors.ink,
    height: 1.2,
  );
 
  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 26,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
    color: AppColors.ink,
    height: 1.25,
  );
 
  static const TextStyle displaySmall = TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
    color: AppColors.ink,
    height: 1.3,
  );
 
  // ── Headlines  (Playfair Display) ─────────────────────────────────────────
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
    color: AppColors.ink,
  );
 
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    color: AppColors.ink,
  );
 
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
  );
 
  // ── Titles  (DM Sans) ─────────────────────────────────────────────────────
  static const TextStyle titleLarge = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: AppColors.ink,
    letterSpacing: 0.1,
  );
 
  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.ink,
    letterSpacing: 0.1,
  );
 
  static const TextStyle titleSmall = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.ink,
    letterSpacing: 0.05,
  );
 
  // ── Body  (DM Sans) ───────────────────────────────────────────────────────
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.ink,
    height: 1.5,
  );
 
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.ink,
    height: 1.5,
  );
 
  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.inkSoft,
    height: 1.4,
  );
 
  // ── Labels  (DM Sans) ─────────────────────────────────────────────────────
  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.ink,
    letterSpacing: 0.1,
  );
 
  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.inkSoft,
    letterSpacing: 0.05,
  );
 
  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.inkSoft,
    letterSpacing: 0.08,
  );
 
  // ── Caps label (section headers) ──────────────────────────────────────────
  static const TextStyle sectionLabel = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.8,
    color: AppColors.inkSoft,
  );
 
  // ── CTA button text ───────────────────────────────────────────────────────
  static const TextStyle ctaButton = TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    color: AppColors.inkSoft
  );
}