import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/core/widget/build_text_field.dart';
import 'package:designers_platform/core/widget/validators.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/designer_profile/presentation/getx/getData_controller_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FilledButtonAddOrder extends StatefulWidget {
  final Designer? currentDesigner;

  const FilledButtonAddOrder({super.key, this.currentDesigner});

  @override
  State<FilledButtonAddOrder> createState() => _FilledButtonAddOrderState();
}

class _FilledButtonAddOrderState extends State<FilledButtonAddOrder> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _type = TextEditingController();

  final TextEditingController _description = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _name.dispose();
    _type.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<GetDataControllerGetx>();

    return FilledButton(
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BuildTextField(
                  controller: _name,
                  label: 'اسم التصميم',
                  hintText: '(لوحة اعلانية، تصميم خطوبة...)',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final name = _name.text.trim();
                            final type = _type.text.trim();
                            final description = _description.text.trim();
                            c.addOrder(widget.currentDesigner!, name, type,
                                description);
                            Get.back();
                          }
                        },
                        icon: Icon(Icons.check_circle_outline),
                        label: Text('تأكيد'),
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
                        onPressed: () {
                          _name.text = '';
                          _type.text = '';
                          _description.text = '';
                          Get.back();
                        },
                        icon: Icon(Icons.close_rounded,
                            color: AppColors.errorColor),
                        label: Text(
                          'إلغاء',
                          style: TextStyle(color: AppColors.errorColor),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: AppColors.errorColor, width: 1.2),
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
        );
      },
      child: Text(
        "طلب خدمة",
        style: TextStyle(fontSize: 15.sp),
      ),
    );
  }
}
