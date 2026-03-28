// ──────────────────────────────────────────────────────────────────────────────
// THEME DATA  –  light
// ──────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'color.dart';
import 'shape.dart';
import 'text.dart';


class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    fontFamily: 'DMSans',

    // ── Color scheme ──────────────────────────────────────────────────────
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      // Primary → accent (terracotta)
      primary: AppColors.accent,
      onPrimary: AppColors.onAccent,
      primaryContainer: AppColors.accentLight,
      onPrimaryContainer: AppColors.accent,
      // Secondary → green (freshness)
      secondary: AppColors.green,
      onSecondary: AppColors.onGreen,
      secondaryContainer: AppColors.greenLight,
      onSecondaryContainer: AppColors.green,
      // Tertiary → ink (CTA buttons)
      tertiary: AppColors.ink,
      onTertiary: AppColors.onInk,
      tertiaryContainer: AppColors.surface2,
      onTertiaryContainer: AppColors.ink,
      // Error → red (expired)
      error: AppColors.red,
      onError: AppColors.onRed,
      errorContainer: AppColors.redLight,
      onErrorContainer: AppColors.red,
      // Surface
      surface: AppColors.surface,
      onSurface: AppColors.ink,
      onSurfaceVariant: AppColors.inkSoft,
      // Outline
      outline: AppColors.border,
      outlineVariant: AppColors.border,
      // Background (scaffold)
      surfaceContainerHighest: AppColors.surface2,
      shadow: Color(0x1A000000),
      scrim: Color(0x80000000),
      inverseSurface: AppColors.ink,
      onInverseSurface: AppColors.onInk,
      inversePrimary: AppColors.accentLight,
    ),

    scaffoldBackgroundColor: AppColors.bg,

    // ── Typography ────────────────────────────────────────────────────────
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    ),

    // ── App Bar ───────────────────────────────────────────────────────────
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bg,
      foregroundColor: AppColors.ink,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.headlineLarge,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      iconTheme: IconThemeData(color: AppColors.ink, size: 20),
    ),

    // ── Card ──────────────────────────────────────────────────────────────
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.cardRadius,
        side: const BorderSide(color: AppColors.border, width: 1.5),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
    ),

    // ── Input / Text Field ────────────────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      hintStyle: const TextStyle(
        fontFamily: 'DMSans',
        fontSize: 15,
        color: Color(0xFFB8B2A6),
      ),
      border: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: const BorderSide(color: AppColors.border, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: const BorderSide(color: AppColors.border, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: const BorderSide(color: AppColors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.inputRadius,
        borderSide: const BorderSide(color: AppColors.red, width: 2),
      ),
      labelStyle: AppTextStyles.labelSmall,
      floatingLabelStyle: AppTextStyles.labelSmall.copyWith(
        color: AppColors.accent,
      ),
    ),

    // ── Elevated Button (primary CTA) ─────────────────────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.ink,
        foregroundColor: AppColors.onInk,
        disabledBackgroundColor: AppColors.border,
        disabledForegroundColor: AppColors.inkSoft,
        elevation: 0,
        shadowColor: Colors.transparent,
        minimumSize: const Size(double.infinity, 54),
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.cardRadius),
        textStyle: AppTextStyles.ctaButton,
      ),
    ),

    // ── Filled Button (accent) ────────────────────────────────────────────
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.onAccent,
        minimumSize: const Size(double.infinity, 54),
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.cardRadius),
        textStyle: AppTextStyles.titleMedium,
      ),
    ),

    // ── Outlined Button (secondary / ghost) ───────────────────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.inkSoft,
        side: const BorderSide(color: AppColors.border, width: 1.5),
        minimumSize: const Size(double.infinity, 48),
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.cardRadius),
        textStyle: AppTextStyles.bodyMedium,
      ),
    ),

    // ── Text Button ───────────────────────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.inkSoft,
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        textStyle: AppTextStyles.bodyMedium,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.cardRadius),
      ),
    ),

    // ── FAB ───────────────────────────────────────────────────────────────
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.onAccent,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      shape: const CircleBorder(),
      extendedTextStyle: AppTextStyles.titleMedium.copyWith(
        color: AppColors.onAccent,
      ),
    ),

    // ── Chip ──────────────────────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surface,
      selectedColor: AppColors.accent,
      disabledColor: AppColors.surface2,
      labelStyle: AppTextStyles.labelMedium,
      secondaryLabelStyle: AppTextStyles.labelMedium.copyWith(
        color: AppColors.onAccent,
      ),
      side: const BorderSide(color: AppColors.border, width: 1.5),
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      showCheckmark: false,
      elevation: 0,
      pressElevation: 0,
    ),

    // ── Switch ────────────────────────────────────────────────────────────
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        return Colors.white;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.green;
        }
        return AppColors.border;
      }),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    ),

    // ── Checkbox ──────────────────────────────────────────────────────────
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.accent;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      side: const BorderSide(color: AppColors.border, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    // ── Radio ─────────────────────────────────────────────────────────────
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.accent;
        }
        return AppColors.border;
      }),
    ),

    // ── Slider ────────────────────────────────────────────────────────────
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.accent,
      inactiveTrackColor: AppColors.border,
      thumbColor: AppColors.accent,
      overlayColor: AppColors.accent.withOpacity(0.15),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
      trackHeight: 3,
      valueIndicatorColor: AppColors.ink,
      valueIndicatorTextStyle: AppTextStyles.labelSmall.copyWith(
        color: Colors.white,
      ),
    ),

    // ── Progress Indicator ────────────────────────────────────────────────
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.accent,
      linearTrackColor: AppColors.border,
      linearMinHeight: 3,
      circularTrackColor: AppColors.border,
    ),

    // ── Divider ───────────────────────────────────────────────────────────
    dividerTheme: const DividerThemeData(
      color: AppColors.border,
      thickness: 1.5,
      space: 1.5,
    ),

    // ── List Tile ─────────────────────────────────────────────────────────
    listTileTheme: const ListTileThemeData(
      tileColor: AppColors.surface,
      contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      minLeadingWidth: 0,
      iconColor: AppColors.inkSoft,
      titleTextStyle: AppTextStyles.bodyMedium,
      subtitleTextStyle: AppTextStyles.bodySmall,
    ),

    // ── Bottom Sheet ──────────────────────────────────────────────────────
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      modalBackgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.sheetRadius),
    ),

    // ── Navigation Bar ────────────────────────────────────────────────────
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.accentLight,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.accent, size: 22);
        }
        return const IconThemeData(color: AppColors.inkSoft, size: 22);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTextStyles.labelSmall.copyWith(color: AppColors.accent);
        }
        return AppTextStyles.labelSmall;
      }),
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      height: 68,
    ),

    // ── Bottom Navigation Bar ─────────────────────────────────────────────
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.accent,
      unselectedItemColor: AppColors.inkSoft,
      selectedLabelStyle: AppTextStyles.labelSmall,
      unselectedLabelStyle: AppTextStyles.labelSmall,
      showUnselectedLabels: true,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),

    // ── Tab Bar ───────────────────────────────────────────────────────────
    tabBarTheme: const TabBarThemeData(
      labelColor: AppColors.accent,
      unselectedLabelColor: AppColors.inkSoft,
      labelStyle: AppTextStyles.titleSmall,
      unselectedLabelStyle: AppTextStyles.labelMedium,
      indicatorColor: AppColors.accent,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: AppColors.border,
    ),

    // ── Snack Bar ─────────────────────────────────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.ink,
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      actionTextColor: AppColors.accentLight,
    ),

    // ── Dialog ────────────────────────────────────────────────────────────
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      titleTextStyle: AppTextStyles.headlineMedium,
      contentTextStyle: AppTextStyles.bodyMedium,
    ),

    // ── Date Picker ───────────────────────────────────────────────────────
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.surface,
      headerBackgroundColor: AppColors.ink,
      headerForegroundColor: Colors.white,
      headerHeadlineStyle: AppTextStyles.headlineLarge.copyWith(
        color: Colors.white,
      ),
      todayForegroundColor: WidgetStateProperty.all(AppColors.accent),
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return AppColors.ink;
      }),
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.accent;
        }
        return Colors.transparent;
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
    ),

    // ── Dropdown ──────────────────────────────────────────────────────────
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: AppTextStyles.bodyMedium,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.surface),
        elevation: WidgetStateProperty.all(0),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: AppRadius.cardRadius,
            side: const BorderSide(color: AppColors.border, width: 1.5),
          ),
        ),
      ),
    ),

    // ── Popup Menu ────────────────────────────────────────────────────────
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.surface,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.cardRadius,
        side: const BorderSide(color: AppColors.border, width: 1.5),
      ),
      textStyle: AppTextStyles.bodyMedium,
    ),

    // ── Icon ─────────────────────────────────────────────────────────────
    iconTheme: const IconThemeData(color: AppColors.inkSoft, size: 20),

    // ── Tooltip ───────────────────────────────────────────────────────────
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      textStyle: AppTextStyles.bodySmall.copyWith(color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    ),
  );
}
