import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        Text(
          "السيرة الذاتية",
          style: AppStyles.headingSmall,
        ),
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
