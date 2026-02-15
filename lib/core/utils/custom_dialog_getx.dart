import 'package:designers_platform/core/widget/build_text_field.dart';
import 'package:designers_platform/features/order_management/presentation/getx/order_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app_colors.dart';
import 'app_styles.dart';

/// أنواع الحوارات المختلفة
enum DialogType {
  info,
  success,
  warning,
  error,
  confirmation,
  rating,
  custom,
}

/// فئة الحوار المخصص لمنصة المصممين مع دعم GetX
class CustomDialog extends StatelessWidget {
  final DialogType type;
  final String title;
  final String? message;
  final Widget? customContent;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final bool barrierDismissible;
  final Widget? icon;
  final double? rating;
  final Function(double)? onRatingChanged;

  const CustomDialog({
    super.key,
    required this.type,
    required this.title,
    this.message,
    this.customContent,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.barrierDismissible = true,
    this.icon,
    this.rating,
    this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20.r),
      child: Container(
        constraints: BoxConstraints(maxWidth: 310.r),
        decoration: BoxDecoration(
          color: AppColorHelper.getCardColor(context),
          borderRadius: AppStyles.dialogRadius,
          boxShadow: AppStyles.heavyShadow,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            _buildContent(context),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      child: Column(
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(height: 16),
          ] else ...[
            _buildDefaultIcon(),
            const SizedBox(height: 16),
          ],
          Text(
            title,
            style: AppStyles.headingSmall.copyWith(
              color: AppColorHelper.getTextColor(context),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultIcon() {
    IconData iconData;
    Color iconColor;

    switch (type) {
      case DialogType.info:
        iconData = Icons.info_rounded;
        iconColor = AppColors.infoColor;
        break;
      case DialogType.success:
        iconData = Icons.check_circle_rounded;
        iconColor = AppColors.successColor;
        break;
      case DialogType.warning:
        iconData = Icons.warning_rounded;
        iconColor = AppColors.warningColor;
        break;
      case DialogType.error:
        iconData = Icons.error_rounded;
        iconColor = AppColors.errorColor;
        break;
      case DialogType.confirmation:
        iconData = Icons.help_rounded;
        iconColor = AppColors.primaryColor;
        break;
      case DialogType.rating:
        iconData = Icons.star_border_rounded;
        iconColor = AppColors.starColor;
        break;
      default:
        iconData = Icons.info_outline;
        iconColor = AppColors.primaryColor;
    }

    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        size: 32,
        color: iconColor,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: Column(
        children: [
          if (message != null) ...[
            Text(
              message!,
              style: AppStyles.bodyMedium.copyWith(
                color: AppColorHelper.getTextColor(context).withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ],
          if (type == DialogType.rating && rating != null) ...[
            _buildRatingWidget(context),
            const SizedBox(height: 16),
          ],
          if (customContent != null) ...[
            customContent!,
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildRatingWidget(BuildContext context) {
    return Column(
      children: [
        Text(
          'قيم التصميم',
          style: AppStyles.bodyMedium.copyWith(
            color: AppColorHelper.getTextColor(context),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => onRatingChanged?.call((index + 1)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  index < (rating ?? 0).floor()
                      ? Icons.star
                      : index < (rating ?? 0)
                          ? Icons.star_half
                          : Icons.star_border,
                  color: AppColors.starColor,
                  size: 32,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    if (primaryButtonText == null && secondaryButtonText == null) {
      return const SizedBox(height: 24);
    }

    return Padding(
      padding: EdgeInsets.all(15.r),
      child: Row(
        children: [
          if (secondaryButtonText != null) ...[
            Expanded(
              child: OutlinedButton(
                onPressed: onSecondaryPressed ?? () => Get.back(),
                style: AppStyles.secondaryButtonStyle,
                child: Text(secondaryButtonText!),
              ),
            ),
            if (primaryButtonText != null) const SizedBox(width: 12),
          ],
          if (primaryButtonText != null) ...[
            Expanded(
              child: ElevatedButton(
                onPressed: onPrimaryPressed ?? () => Get.back(),
                style: AppStyles.secondaryButtonStyle,
                child: Text(
                  primaryButtonText!,
                  style: TextStyle(fontSize: 15.sp),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// فئة مساعدة لعرض الحوارات المختلفة باستخدام GetX
class DialogHelper {
  /// عرض حوار المعلومات
  static Future<void> showInfoDialog({
    required String title,
    required String message,
    String buttonText = 'حسناً',
    VoidCallback? onPressed,
  }) {
    return Get.dialog(
      CustomDialog(
        type: DialogType.info,
        title: title,
        message: message,
        primaryButtonText: buttonText,
        onPrimaryPressed: onPressed,
      ),
      barrierDismissible: true,
    );
  }

  /// عرض حوار النجاح
  static Future<void> showSuccessDialog({
    required String title,
    required String message,
    String buttonText = 'رائع',
    VoidCallback? onPressed,
  }) {
    return Get.dialog(
      CustomDialog(
        type: DialogType.success,
        title: title,
        message: message,
        primaryButtonText: buttonText,
        onPrimaryPressed: onPressed,
      ),
      barrierDismissible: true,
    );
  }

  /// عرض حوار التحذير
  static Future<void> showWarningDialog({
    required String title,
    required String message,
    required String buttonText,
    VoidCallback? onPressed,
  }) {
    return Get.dialog(
      CustomDialog(
        type: DialogType.warning,
        title: title,
        message: message,
        primaryButtonText: buttonText,
        onPrimaryPressed: onPressed,
      ),
      barrierDismissible: true,
    );
  }

  /// عرض حوار الخطأ
  static Future<void> showErrorDialog({
    required String title,
    required String message,
    String buttonText = 'حسناً',
    VoidCallback? onPressed,
  }) {
    return Get.dialog(
      CustomDialog(
        type: DialogType.error,
        title: title,
        message: message,
        primaryButtonText: buttonText,
        onPrimaryPressed: onPressed,
      ),
      barrierDismissible: true,
    );
  }

  /// عرض حوار التأكيد
  static Future<bool?> showConfirmationDialog({
    required String title,
    required String message,
    String confirmText = 'تأكيد',
    String cancelText = 'إلغاء',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return Get.dialog<bool>(
      CustomDialog(
        type: DialogType.confirmation,
        title: title,
        message: message,
        primaryButtonText: confirmText,
        secondaryButtonText: cancelText,
        onPrimaryPressed: () {
          Get.back(result: true);
          onConfirm?.call();
        },
        onSecondaryPressed: () {
          Get.back(result: false);
          onCancel?.call();
        },
      ),
      barrierDismissible: true,
    );
  }

  /// عرض حوار التقييم
  static Future<double?> showRatingDialog({
    required String designerId,
    required String orderId,
    required String title,
    String? message,
    double initialRating = 0.0,
    String submitText = 'إرسال التقييم',
    String cancelText = 'إلغاء',
  }) {
    final c = Get.find<OrderGetx>();

    // ضبط القيمة الابتدائية
    c.currentRating.value = initialRating;

    return Get.dialog<double>(
      Obx(
        () => CustomDialog(
          type: DialogType.rating,
          title: title,
          message: message,
          customContent: Column(
            children: [
              Text(
                'ملاحظات',
                style: AppStyles.bodyLarge,
              ),
              SizedBox(
                height: 5.h,
              ),
              BuildTextField(
                controller: c.feedback.value,
              )
            ],
          ),
          rating: c.currentRating.value, // 👈 هنا نستخدم Rx
          onRatingChanged: (rating) {
            c.currentRating.value = rating; // 👈 تحديث Rx
          },
          primaryButtonText: submitText,
          secondaryButtonText: cancelText,
          onPrimaryPressed: () {
            c.addReview(designerId, orderId);
            Get.back(result: c.currentRating.value);
          },
          onSecondaryPressed: () {
            Get.back();
          },
        ),
      ),
      barrierDismissible: true,
    );
  }

  /// عرض حوار مخصص
  static Future<T?> showCustomDialog<T>({
    required String title,
    String? message,
    required Widget customContent,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    Widget? customIcon,
  }) {
    return Get.dialog<T>(
      SingleChildScrollView(
        child: CustomDialog(
          type: DialogType.custom,
          title: title,
          message: message,
          customContent: customContent,
          primaryButtonText: primaryButtonText,
          secondaryButtonText: secondaryButtonText,
          onPrimaryPressed: onPrimaryPressed,
          onSecondaryPressed: onSecondaryPressed,
          icon: customIcon,
        ),
      ),
      barrierDismissible: true,
    );
  }

  /// عرض Bottom Sheet مخصص باستخدام GetX
  static Future<T?> showCustomBottomSheet<T>({
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return Get.bottomSheet<T>(
      Container(
        decoration: BoxDecoration(
          color: AppColorHelper.getCardColor(Get.context!),
          borderRadius: AppStyles.bottomSheetRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // مقبض السحب
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color:
                    AppColorHelper.getTextColor(Get.context!).withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            child,
          ],
        ),
      ),
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
    );
  }

  /// عرض SnackBar باستخدام GetX
  static void showSnackBar({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.BOTTOM,
    Color? backgroundColor,
    Color? colorText,
    Duration duration = const Duration(seconds: 2),
    Widget? icon,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.context == null) return;

      Get.snackbar(
        title,
        message,
        snackPosition: position,
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        colorText: colorText ?? AppColors.textOnPrimary,
        duration: duration,
        icon: icon,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
      );
    });
  }

  /// عرض SnackBar للنجاح
  static void showSuccessSnackBar({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    showSnackBar(
      title: title,
      message: message,
      backgroundColor: AppColors.successColor,
      icon: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.check_circle, color: Colors.white),
      ),
      duration: duration,
    );
  }

  /// عرض SnackBar للخطأ
  static void showErrorSnackBar({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    showSnackBar(
      title: title,
      message: message,
      backgroundColor: AppColors.errorColor,
      icon: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.error, color: Colors.white),
      ),
      duration: duration,
    );
  }

  /// عرض SnackBar للتحذير
  static void showWarningSnackBar({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    showSnackBar(
      title: title,
      message: message,
      backgroundColor: AppColors.warningColor,
      icon: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.warning, color: Colors.white),
      ),
      duration: duration,
    );
  }
}

/// حوار تحميل مخصص مع GetX
class LoadingDialog extends StatelessWidget {
  final String message;
  final bool canCancel;
  final VoidCallback? onCancel;

  const LoadingDialog({
    Key? key,
    this.message = 'جاري التحميل...',
    this.canCancel = false,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColorHelper.getCardColor(context),
          borderRadius: AppStyles.dialogRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppStyles.loadingIndicator,
            const SizedBox(height: 16),
            Text(
              message,
              style: AppStyles.bodyMedium.copyWith(
                color: AppColorHelper.getTextColor(context),
              ),
              textAlign: TextAlign.center,
            ),
            if (canCancel) ...[
              const SizedBox(height: 16),
              TextButton(
                onPressed: onCancel ?? () => Get.back(),
                child: const Text('إلغاء'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// عرض حوار التحميل باستخدام GetX
  static void show({
    String message = 'جاري التحميل...',
    bool canCancel = false,
    VoidCallback? onCancel,
  }) {
    Get.dialog(
      LoadingDialog(
        message: message,
        canCancel: canCancel,
        onCancel: onCancel,
      ),
      barrierDismissible: canCancel,
    );
  }

  /// إخفاء حوار التحميل
  static void hide() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}
