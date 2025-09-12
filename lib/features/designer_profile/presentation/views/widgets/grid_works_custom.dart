import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridWorksCustom extends StatelessWidget {
  const GridWorksCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(clipBehavior: Clip.none, children: [
          Positioned(
            top: 10.r,
            child: Container(
              margin: EdgeInsets.only(top: 10.r, bottom: 20.r),
              width: 85.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: AppStyles.mediumRadius,
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.only(top: 8.r),
              child: Row(
                children: [
                  Icon(Icons.work_outline_rounded),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "أعمالي",
                    style: AppStyles.headingSmall,
                  ),
                ],
              ),
            ),
          ),
        ]),
        Container(
          margin: EdgeInsets.only(top: 10.r),
          child: GridView.builder(
            shrinkWrap: true, // مهم عشان يشتغل داخل سكروول
            physics:
                const NeverScrollableScrollPhysics(), // يعطل التمرير الداخلي
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 أعمدة مثل انستا
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: 30,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                ),
                child: Center(
                    child: Text(
                  "Post ${index + 1}",
                  style: AppStyles.bodySmall,
                )),
              );
            },
          ),
        ),
      ],
    );
  }
}
