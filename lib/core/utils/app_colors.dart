import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// نظام الألوان الخاص بمنصة المصممين
/// يحتوي على جميع الألوان المستخدمة في التطبيق مع دعم الوضع المظلم والفاتح
class AppColors {
  // الألوان الأساسية للتطبيق
  static const Color primaryColor = Color(0xFF6C5CE7); // بنفسجي أنيق
  static const Color secondaryColor = Color(0xFF74B9FF); // أزرق فاتح
  static const Color accentColor = Color(0xFFFF7675); // وردي مرجاني

  // ألوان الخلفية
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFFFFFF);

  // ألوان النصوص
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textHint = Color(0xFFB2BEC3);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ألوان الحالة
  static const Color successColor = Color(0xFF00B894);
  static const Color warningColor = Color(0xFFE17055);
  static const Color errorColor = Color(0xFFD63031);
  static const Color infoColor = Color(0xFF0984E3);

  // ألوان التقييم والنجوم
  static const Color starColor = Color(0xFFFDCB6E);
  static const Color ratingBackground = Color(0xFFF1F2F6);

  // ألوان الحدود والفواصل
  static const Color borderColor = Color(0xFFDDD6FE);
  static const Color dividerColor = Color(0xFFE2E8F0);

  // ألوان الوضع المظلم
  static const Color darkBackgroundColor = Color(0xFF1A1A1A);
  static const Color darkSurfaceColor = Color(0xFF2D2D2D);
  static const Color darkCardColor = Color(0xFF3A3A3A);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkBorderColor = Color(0xFF4A4A4A);

  // تدرجات لونية للتصميم
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8F9FA)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF3A3A3A), Color(0xFF2D2D2D)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

/// فئة الثيمات الخاصة بالتطبيق
class AppThemes {
  /// الثيم الفاتح
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    // fontFamily: "adobe_arabic",
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,

    // نظام الألوان الجديد في Material 3
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      surface: AppColors.surfaceColor,
      error: AppColors.errorColor,
      onPrimary: AppColors.textOnPrimary,
      onSecondary: AppColors.textOnPrimary,
      onSurface: AppColors.textPrimary,
      onError: AppColors.textOnPrimary,
    ),

    // تخصيص AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surfaceColor,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 20.0.r,
        fontWeight: FontWeight.w600,
      ),
    ),

    // تخصيص البطاقات
    cardTheme: CardThemeData(
      color: AppColors.cardColor,
      elevation: 2,
      shadowColor: AppColors.primaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    // تخصيص الأزرار
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 2,
        shadowColor: AppColors.primaryColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    // تخصيص حقول الإدخال
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  );

  /// الثيم المظلم
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    // fontFamily: "adobe_arabic",
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      surface: AppColors.darkSurfaceColor,
      error: AppColors.errorColor,
      onPrimary: AppColors.textOnPrimary,
      onSecondary: AppColors.textOnPrimary,
      onSurface: AppColors.darkTextPrimary,
      onError: AppColors.textOnPrimary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkSurfaceColor,
      foregroundColor: AppColors.darkTextPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.darkTextPrimary,
        fontSize: 20.r,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkCardColor,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 2,
        shadowColor: AppColors.primaryColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  );
}

/// فئة مساعدة للحصول على الألوان حسب السياق
class AppColorHelper {
  /// الحصول على لون النص الأساسي حسب السطوع
  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkTextPrimary
        : AppColors.textPrimary;
  }

  /// الحصول على لون الخلفية حسب السطوع
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkBackgroundColor
        : AppColors.backgroundColor;
  }

  /// الحصول على لون البطاقة حسب السطوع
  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkCardColor
        : AppColors.cardColor;
  }

  /// الحصول على لون الحدود حسب السطوع
  static Color getBorderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkBorderColor
        : AppColors.borderColor;
  }
}
