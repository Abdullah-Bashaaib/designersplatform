import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';

class BioCustom extends StatelessWidget {
  const BioCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Stack(clipBehavior: Clip.none, children: [
          Positioned(
            top: 5.r,
            child: Container(
              margin: EdgeInsets.only(top: 10.r, bottom: 20.r),
              width: 140.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: AppStyles.mediumRadius,
              ),
            ),
          ),
          Row(
            children: [
              Icon(Icons.info_outline_rounded),
              SizedBox(width: 5.w),
              Text(
                "السيرة الذاتية",
                style: AppStyles.headingSmall,
              ),
            ],
          ),
        ]),
        SizedBox(
          height: 10.h,
        ),
        Text(
          "مصمم جرافيك محترف بخبرة تزيد عن 5 سنوات في تصميم الشعارات والهوية البصرية.",
          style: AppStyles.bodySmall,
        ),
      ],
    );
  }
}
