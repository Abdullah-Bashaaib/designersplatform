import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/features/designer_profile/presentation/getx/getData_controller_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BioCustom extends StatelessWidget {
  final String? currentBio;
  BioCustom({
    super.key,
    this.currentBio,
  });
  final controller = Get.find<GetDataControllerGetx>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        SizedBox(
          height: 10.h,
        ),
        Obx(
          () {
            final designer = controller.designerR.value;
            return Skeletonizer(
              enabled: controller.isLoading.value,
              child: designer == null
                  ? Text("لا توجد بيانات")
                  : Text(
                      currentBio ?? designer.bio!,
                      style: AppStyles.bodyMedium,
                    ),
            );
          },
        ),
      ],
    );
  }
}
