import 'package:flutter/material.dart';
import 'package:nexacloth/components/appcolor.dart';
import 'package:nexacloth/components/apptextstyle.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: CustomAppColor.primary,
        secondary: CustomAppColor.secondary,
        tertiary: CustomAppColor.accent,
        error: CustomAppColor.error,
        surface: CustomAppColor.card,
        background: CustomAppColor.background,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onTertiary: Colors.white,
        onError: Colors.white,
        onSurface: CustomAppColor.text,
        onBackground: CustomAppColor.text,
      ),

      // Scaffold Background
      scaffoldBackgroundColor: CustomAppColor.background,

      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTextStyle.h1,
        displayMedium: AppTextStyle.h2,
        displaySmall: AppTextStyle.h3,
        headlineLarge: AppTextStyle.h1,
        headlineMedium: AppTextStyle.h2,
        headlineSmall: AppTextStyle.h3,
        titleLarge: AppTextStyle.h4,
        titleMedium: AppTextStyle.h5,
        titleSmall: AppTextStyle.h6,
        bodyLarge: AppTextStyle.bodyLarge,
        bodyMedium: AppTextStyle.bodyMedium,
        bodySmall: AppTextStyle.bodySmall,
        labelLarge: AppTextStyle.buttonLarge,
        labelMedium: AppTextStyle.buttonMedium,
        labelSmall: AppTextStyle.buttonSmall,
      ),

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: CustomAppColor.card,
        foregroundColor: CustomAppColor.text,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyle.h5.copyWith(color: CustomAppColor.text),
        iconTheme: IconThemeData(color: CustomAppColor.text),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: CustomAppColor.card,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: CustomAppColor.subtext.withOpacity(0.1),
            width: 1,
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // Input Decoration Theme (for TextFields)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: CustomAppColor.card,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: CustomAppColor.subtext.withOpacity(0.3),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: CustomAppColor.subtext.withOpacity(0.3),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: CustomAppColor.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: CustomAppColor.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: CustomAppColor.error, width: 2),
        ),
        labelStyle: AppTextStyle.bodyMedium.copyWith(
          color: CustomAppColor.subtext,
        ),
        hintStyle: AppTextStyle.bodyMedium.copyWith(
          color: CustomAppColor.subtext,
        ),
        errorStyle: AppTextStyle.error,
        // Add underline color for primary in TextFields
        // Note: In Flutter, to theme underline color for text fields, use 'underlineInputBorder' for InputDecorationTheme if you want to specifically set it.
        // Otherwise, cursorColor can also be set at the ThemeData level.
        // The modern outlined style (default here) uses the focusedBorder color (already set to primary).
        // If you also want to set the underline, it could be set as:
        // uncomment if you use UnderlineInputBorder:
        // enabledBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(color: CustomAppColor.primary),
        // ),
        // focusedBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(color: CustomAppColor.primary, width: 2),
        // ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomAppColor.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyle.buttonLarge,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: CustomAppColor.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: AppTextStyle.buttonMedium.copyWith(
            decorationColor: CustomAppColor.primary,
            decoration: TextDecoration.underline,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: CustomAppColor.primary,
          side: BorderSide(color: CustomAppColor.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyle.buttonMedium,
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: CustomAppColor.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      // Icon Theme
      iconTheme: IconThemeData(color: CustomAppColor.text, size: 24),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: CustomAppColor.subtext.withOpacity(0.2),
        thickness: 1,
        space: 1,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: CustomAppColor.background,
        deleteIconColor: CustomAppColor.subtext,
        disabledColor: CustomAppColor.subtext.withOpacity(0.1),
        selectedColor: CustomAppColor.primary.withOpacity(0.2),
        secondarySelectedColor: CustomAppColor.secondary.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelStyle: AppTextStyle.bodySmall,
        secondaryLabelStyle: AppTextStyle.bodySmall,
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: CustomAppColor.subtext.withOpacity(0.2)),
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: CustomAppColor.card,
        selectedItemColor: CustomAppColor.primary,
        unselectedItemColor: CustomAppColor.subtext,
        selectedLabelStyle: AppTextStyle.caption,
        unselectedLabelStyle: AppTextStyle.caption,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: CustomAppColor.card,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: AppTextStyle.h5,
        contentTextStyle: AppTextStyle.bodyMedium,
      ),

      // Snackbar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: CustomAppColor.text,
        contentTextStyle: AppTextStyle.bodyMedium.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: CustomAppColor.primary,
        linearTrackColor: CustomAppColor.subtext.withOpacity(0.2),
        circularTrackColor: CustomAppColor.subtext.withOpacity(0.2),
      ),
      // Add underline color globally for text (including links)
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: CustomAppColor.primary,
        selectionColor: CustomAppColor.primary.withOpacity(0.2),
        selectionHandleColor: CustomAppColor.primary,
      ),
    );
  }

  // You can add dark theme here in the future
  // static ThemeData get darkTheme {
  //   return ThemeData(
  //     // Dark theme configuration
  //   );
  // }
}
