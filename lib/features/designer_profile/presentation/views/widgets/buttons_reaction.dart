import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/designer_profile/presentation/getx/getData_controller_getx.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/screens/update_profile.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/widgets/filled_button_add_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ButtonsReaction extends StatelessWidget {
  final Designer? currentDesigner;
  const ButtonsReaction({
    super.key,
    this.currentDesigner,
  });

  @override
  Widget build(BuildContext context) {
    final c = Get.find<GetDataControllerGetx>();
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        CurrentUser.currentUser!.role == 'مصمم'
            ? SizedBox(height: 0.h)
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 175.w,
                    child: Obx(
                      () => c.isLoadingAddOrder.value
                          ? Center(child: CircularProgressIndicator())
                          : FilledButtonAddOrder(
                              currentDesigner: currentDesigner,
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
                      ),
                    ),
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
                child: FilledButton(
                  style: AppStyles.secondaryButtonStyle,
                  onPressed: () {
                    Get.to(() => UpdateProfile());
                  },
                  child: Text(
                    "تعديل الملف الشخصي",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
              ),
      ],
    );
  }
}
