import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

/// فئة الأنماط والحواف الناعمة للتطبيق
/// تحتوي على جميع أنماط التصميم المستخدمة في منصة المصممين
class AppStyles {
  // أنماط الحواف المختلفة
  static BorderRadius smallRadius = BorderRadius.all(Radius.circular(8.r));
  static BorderRadius mediumRadius = BorderRadius.all(Radius.circular(12.r));
  static BorderRadius largeRadius = BorderRadius.all(Radius.circular(16.r));
  static BorderRadius extraLargeRadius =
      BorderRadius.all(Radius.circular(24.r));
  static BorderRadius circularRadius = BorderRadius.all(Radius.circular(50.r));

  // أنماط الحواف المخصصة للعناصر المختلفة
  static BorderRadius cardRadius = BorderRadius.all(Radius.circular(16.r));
  static BorderRadius buttonRadius = BorderRadius.all(Radius.circular(12.r));
  static BorderRadius inputRadius = BorderRadius.all(Radius.circular(12.r));
  static BorderRadius dialogRadius = BorderRadius.all(Radius.circular(20.r));
  static BorderRadius bottomSheetRadius = BorderRadius.only(
    topLeft: Radius.circular(24.r),
    topRight: Radius.circular(24.r),
  );

  // أنماط الظلال
  static List<BoxShadow> get lightShadow => [
        BoxShadow(
          color: AppColors.primaryColor.withValues(alpha: 0.08),
          blurRadius: 8.r,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get mediumShadow => [
        BoxShadow(
          color: AppColors.primaryColor.withValues(alpha: 0.12),
          blurRadius: 12.r,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get heavyShadow => [
        BoxShadow(
          color: AppColors.primaryColor.withValues(alpha: 0.16),
          blurRadius: 16.r,
          offset: const Offset(0, 6),
        ),
      ];

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10.r,
          offset: const Offset(0, 2),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          blurRadius: 20.r,
          offset: const Offset(0, 4),
        ),
      ];

  // أنماط النصوص
  static final TextStyle headingLarge = TextStyle(
    // fontFamily: "Doran",
    fontSize: 30.sp,
    fontWeight: FontWeight.bold,
    height: 1.2.h,
  );

  static TextStyle headingMedium = TextStyle(
    // fontFamily: "Doran",
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    height: 1.3.h,
  );

  static TextStyle headingSmall = TextStyle(
    // fontFamily: "Doran",
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 1.3.h,
  );

  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    height: 1.5.h,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    height: 1.4.h,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    height: 1.4.h,
  );

  static TextStyle caption = TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.normal,
    height: 1.3.h,
  );

  // أنماط الأزرار
  static ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 2,
        shadowColor: AppColors.primaryColor.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(borderRadius: buttonRadius),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textOnPrimary,
        ),
      );

  static ButtonStyle get secondaryButtonStyle => OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
        shape: RoundedRectangleBorder(borderRadius: buttonRadius),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      );

  static ButtonStyle get ghostButtonStyle => TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: buttonRadius),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      );

  // أنماط البطاقات
  static BoxDecoration get cardDecoration => BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: cardRadius,
        boxShadow: cardShadow,
      );

  static BoxDecoration get darkCardDecoration => BoxDecoration(
        color: AppColors.darkCardColor,
        borderRadius: cardRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10.r,
            offset: const Offset(0, 2),
          ),
        ],
      );

  // أنماط حقول الإدخال
  static InputDecoration getInputDecoration({
    required String hintText,
    String? labelText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) =>
      InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        // fillColor: AppColors.surfaceColor,
        border: OutlineInputBorder(
          borderRadius: inputRadius,
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: inputRadius,
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: inputRadius,
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: inputRadius,
          borderSide: const BorderSide(color: AppColors.errorColor),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      );

  // أنماط التقييم والنجوم
  static Widget buildRatingStars(double rating, {double size = 16}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor()
              ? Icons.star
              : index < rating
                  ? Icons.star_half
                  : Icons.star_border,
          color: AppColors.starColor,
          size: size,
        );
      }),
    );
  }

  // أنماط الشارات والعلامات
  static BoxDecoration get badgeDecoration => BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      );

  static BoxDecoration get successBadgeDecoration => BoxDecoration(
        color: AppColors.successColor,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      );

  static BoxDecoration get warningBadgeDecoration => BoxDecoration(
        color: AppColors.warningColor,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      );

  static BoxDecoration get errorBadgeDecoration => BoxDecoration(
        color: AppColors.errorColor,
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
      );

  // أنماط الفواصل
  static Widget get horizontalDivider => Container(
        height: 1.h,
        color: AppColors.dividerColor,
      );

  static Widget get verticalDivider => Container(
        width: 1.w,
        color: AppColors.dividerColor,
      );

  // أنماط التحميل والانتظار
  static Widget get loadingIndicator => const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
        strokeWidth: 3,
      );

  static Widget get smallLoadingIndicator => const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          strokeWidth: 2,
        ),
      );
}

/// فئة مساعدة للحصول على الأنماط حسب السياق
class AppStyleHelper {
  /// الحصول على تزيين البطاقة حسب السطوع
  static BoxDecoration getCardDecoration(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppStyles.darkCardDecoration
        : AppStyles.cardDecoration;
  }

  /// الحصول على لون النص حسب النوع والسياق
  static TextStyle getTextStyle(BuildContext context, TextStyle baseStyle) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return baseStyle.copyWith(
      color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
    );
  }

  /// الحصول على تزيين حقل الإدخال حسب السياق
  static InputDecoration getContextualInputDecoration(
    BuildContext context, {
    required String hintText,
    String? labelText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: isDark ? AppColors.darkSurfaceColor : AppColors.surfaceColor,
      border: OutlineInputBorder(
        borderRadius: AppStyles.inputRadius,
        borderSide: BorderSide(
          color: isDark ? AppColors.darkBorderColor : AppColors.borderColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppStyles.inputRadius,
        borderSide: BorderSide(
          color: isDark ? AppColors.darkBorderColor : AppColors.borderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppStyles.inputRadius,
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppStyles.inputRadius,
        borderSide: const BorderSide(color: AppColors.errorColor),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}

/// فئة الحركات والانتقالات الناعمة
class AppAnimations {
  // مدة الحركات
  static const Duration fastDuration = Duration(milliseconds: 200);
  static const Duration normalDuration = Duration(milliseconds: 300);
  static const Duration slowDuration = Duration(milliseconds: 500);

  // منحنيات الحركة
  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve smoothCurve = Curves.easeOutCubic;

  // حركة الظهور التدريجي
  static Widget fadeIn({
    required Widget child,
    Duration duration = normalDuration,
    Curve curve = defaultCurve,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }

  // حركة الانزلاق من الأسفل
  static Widget slideUp({
    required Widget child,
    Duration duration = normalDuration,
    Curve curve = defaultCurve,
  }) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: const Offset(0, 1), end: Offset.zero),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Transform.translate(
          offset: value * 50,
          child: child,
        );
      },
      child: child,
    );
  }

  // حركة التكبير
  static Widget scaleIn({
    required Widget child,
    Duration duration = normalDuration,
    Curve curve = bounceCurve,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }
}
