import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonsReaction extends StatelessWidget {
  const ButtonsReaction({
    super.key,
  });

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
                  onPressed: () {},
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
                  onPressed: () {},
                  child: Text(
                    "تقييم المصمم",
                    style: TextStyle(fontSize: 15.sp),
                  )),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 10.r),
          width: double.infinity,
          child: OutlinedButton(
            style: AppStyles.secondaryButtonStyle,
            onPressed: () {},
            child:
                Text("تعديل الملف الشخصي", style: TextStyle(fontSize: 15.sp)),
          ),
        ),
      ],
    );
  }
}
