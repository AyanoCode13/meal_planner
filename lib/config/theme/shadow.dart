// ──────────────────────────────────────────────────────────────────────────────
// SHADOW TOKENS
// ──────────────────────────────────────────────────────────────────────────────
 
import 'package:flutter/material.dart';

import 'color.dart';



class AppShadows {
  AppShadows._();
 
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x17000000),
      blurRadius: 16,
      offset: Offset(0, 2),
    ),
  ];
 
  static const List<BoxShadow> cta = [
    BoxShadow(
      color: Color(0x40000000),
      blurRadius: 20,
      offset: Offset(0, 6),
    ),
  ];
 
  static List<BoxShadow> accentFab = [
    BoxShadow(
      color: AppColors.accent.withOpacity(0.35),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
 
  static const List<BoxShadow> circleButton = [
    BoxShadow(
      color: Color(0x17000000),
      blurRadius: 16,
      offset: Offset(0, 2),
    ),
  ];
}