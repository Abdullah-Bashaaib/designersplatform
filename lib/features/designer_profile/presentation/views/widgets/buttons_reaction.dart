import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/screens/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/current_user.dart';
import '../../getx/getData_controller_getx.dart';

class ButtonsReaction extends StatelessWidget {
  ButtonsReaction({
    super.key,
  });
  final controller = Get.find<GetDataControllerGetx>();
  @override
  Widget build(BuildContext context) {
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
              child: FilledButton(
                  style: AppStyles.secondaryButtonStyle,
                  onPressed: () {
                    DialogHelper.showInfoDialog(
                        title: "title", message: "message");
                  },
                  child: Text(
                    "طلب خدمة",
                    style: TextStyle(fontSize: 15.sp),
                  )),
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
        CurrentUser.currentUser?.role == 'مصمم'
            ? Container(
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
              )
            : SizedBox(),
      ],
    );
  }
}
