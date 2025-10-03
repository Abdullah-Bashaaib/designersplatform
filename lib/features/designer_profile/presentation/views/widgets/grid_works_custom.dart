import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/features/designer_profile/presentation/getx/getData_controller_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/app_image.dart';

class GridWorksCustom extends StatelessWidget {
  GridWorksCustom({
    super.key,
  });
  final controller = Get.find<GetDataControllerGetx>();
  @override
  Widget build(BuildContext context) {
    final designer = controller.designer.value!;
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
            itemCount: designer.worksCount,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                ),
                child: Image.network(
                  designer.workList![index].imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: SizedBox(
                        width: 30.r,
                        height: 30.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.w,
                          color: AppColors.primaryColor,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppImage.profileImage,
                      fit: BoxFit.cover,
                      width: 100.w,
                      height: 100.h,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
