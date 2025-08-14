import 'package:flutter/material.dart';
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
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
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
      padding: const EdgeInsets.all(24),
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
        iconData = Icons.info_outline;
        iconColor = AppColors.infoColor;
        break;
      case DialogType.success:
        iconData = Icons.check_circle_outline;
        iconColor = AppColors.successColor;
        break;
      case DialogType.warning:
        iconData = Icons.warning_amber_outlined;
        iconColor = AppColors.warningColor;
        break;
      case DialogType.error:
        iconData = Icons.error_outline;
        iconColor = AppColors.errorColor;
        break;
      case DialogType.confirmation:
        iconData = Icons.help_outline;
        iconColor = AppColors.primaryColor;
        break;
      case DialogType.rating:
        iconData = Icons.star_outline;
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
              onTap: () => onRatingChanged?.call((index + 1).toDouble()),
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
      padding: const EdgeInsets.all(24),
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
                style: AppStyles.primaryButtonStyle,
                child: Text(primaryButtonText!),
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
    String buttonText = 'فهمت',
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
    required String title,
    String? message,
    double initialRating = 0,
    String submitText = 'إرسال التقييم',
    String cancelText = 'إلغاء',
  }) {
    double currentRating = initialRating;
    
    return Get.dialog<double>(
      StatefulBuilder(
        builder: (context, setState) => CustomDialog(
          type: DialogType.rating,
          title: title,
          message: message,
          rating: currentRating,
          onRatingChanged: (rating) {
            setState(() {
              currentRating = rating;
            });
          },
          primaryButtonText: submitText,
          secondaryButtonText: cancelText,
          onPrimaryPressed: () {
            Get.back(result: currentRating);
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
      CustomDialog(
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
                color: AppColorHelper.getTextColor(Get.context!).withOpacity(0.3),
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
    Duration duration = const Duration(seconds: 3),
    Widget? icon,
  }) {
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
  }

  /// عرض SnackBar للنجاح
  static void showSuccessSnackBar({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    showSnackBar(
      title: title,
      message: message,
      backgroundColor: AppColors.successColor,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      duration: duration,
    );
  }

  /// عرض SnackBar للخطأ
  static void showErrorSnackBar({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    showSnackBar(
      title: title,
      message: message,
      backgroundColor: AppColors.errorColor,
      icon: const Icon(Icons.error, color: Colors.white),
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
      icon: const Icon(Icons.warning, color: Colors.white),
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

