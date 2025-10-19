import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/core/widget/build_text_field.dart';
import 'package:designers_platform/core/widget/validators.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/designer_profile/presentation/getx/getData_controller_getx.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/screens/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ButtonsReaction extends StatelessWidget {
  final Designer? currentDesigner;
  ButtonsReaction({
    super.key,
    this.currentDesigner,
  });
  final TextEditingController _name = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<GetDataControllerGetx>();
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 175.w,
              child: Obx(
                () => c.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : FilledButton(
                        style: AppStyles.secondaryButtonStyle,
                        onPressed: () {
                          DialogHelper.showCustomDialog(
                            customIcon: Icon(
                              Icons.design_services_sharp,
                              color: AppColors.primaryColor,
                            ),
                            title: 'طلب خدمة',
                            customContent: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                // ✅ هنا أضفناها
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    BuildTextField(
                                      controller: _name,
                                      label: 'اسم التصميم',
                                      hintText:
                                          '(لوحة اعلانية، تصميم خطوبة...)',
                                      validator: Validators.global,
                                    ),
                                    SizedBox(height: 10.h),
                                    BuildTextField(
                                      controller: _type,
                                      label: 'نوع التصميم',
                                      hintText: '(بوستر، شعار، هوية بصرية...)',
                                      validator: Validators.global,
                                    ),
                                    SizedBox(height: 10.h),
                                    BuildTextField(
                                      controller: _description,
                                      label: 'وصف التصميم',
                                      maxLines: 3,
                                      hintText: 'اشرح فكرتك للمصمم هنا...',
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                final name = _name.text.trim();
                                                final type = _type.text.trim();
                                                final description =
                                                    _description.text.trim();
                                                c.addOrder(currentDesigner!,
                                                    name, type, description);
                                                Get.back();
                                              }
                                            },
                                            icon: Icon(
                                                Icons.check_circle_outline),
                                            label: Text('تأكيد'),
                                            style: AppStyles.primaryButtonStyle
                                                .copyWith(
                                              padding: WidgetStateProperty.all(
                                                EdgeInsets.symmetric(
                                                    vertical: 12.h),
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
                                            label: Text(
                                              'إلغاء',
                                              style: TextStyle(
                                                  color: AppColors.errorColor),
                                            ),
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                  color: AppColors.errorColor,
                                                  width: 1.2),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12.h),
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
                        },
                        child: Text(
                          "طلب خدمة",
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10.r),
              width: 175.w,
              child: OutlinedButton(
                  style: AppStyles.secondaryButtonStyle,
                  onPressed: () {
                    DialogHelper.showInfoDialog(
                        title: "title", message: "message");
                  },
                  child: Text(
                    "تقييم المصمم",
                    style: TextStyle(fontSize: 15.sp),
                  )),
            ),
          ],
        ),
        CurrentUser.currentUser!.role == 'عميل'
            ? SizedBox(
                height: 10.h,
              )
            : Container(
                padding: EdgeInsets.only(top: 10.r),
                width: double.infinity,
                child: OutlinedButton(
                  style: AppStyles.secondaryButtonStyle,
                  onPressed: () {
                    Get.to(() => UpdateProfile());
                  },
                  child: Text("تعديل الملف الشخصي",
                      style: TextStyle(fontSize: 15.sp)),
                ),
              ),
      ],
    );
  }
}
