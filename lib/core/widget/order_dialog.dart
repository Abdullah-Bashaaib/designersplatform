import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/core/widget/build_text_field.dart';
import 'package:designers_platform/core/widget/validators.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderDialog {
  /// دالة عامة لعرض الديالوج
  static void show({
    required String title,
    required Function(String type, String description) onConfirm,
    Designer? currentDesigner,
    String? initialType,
    String? initialDescription,
  }) {
    final formKey = GlobalKey<FormState>();
    final type0 = TextEditingController(text: initialType ?? '');
    final description0 = TextEditingController(text: initialDescription ?? '');

    DialogHelper.showCustomDialog(
      customIcon:
          Icon(Icons.design_services_sharp, color: AppColors.primaryColor),
      title: title,
      customContent: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h),
              BuildTextField(
                controller: type0,
                label: 'نوع التصميم',
                hintText: '(بوستر، شعار، هوية بصرية...)',
                validator: Validators.global,
              ),
              SizedBox(height: 10.h),
              BuildTextField(
                controller: description0,
                label: 'وصف التصميم',
                maxLines: 3,
                hintText: 'اشرح فكرتك للمصمم هنا...',
                validator: Validators.global,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final type = type0.text.trim();
                          final description = description0.text.trim();
                          onConfirm(type, description);
                          Get.back();
                        }
                      },
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('تأكيد'),
                      style: AppStyles.primaryButtonStyle.copyWith(
                        padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.close_rounded,
                          color: AppColors.errorColor),
                      label: Text('إلغاء',
                          style: TextStyle(color: AppColors.errorColor)),
                      style: OutlinedButton.styleFrom(
                        side:
                            BorderSide(color: AppColors.errorColor, width: 1.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
