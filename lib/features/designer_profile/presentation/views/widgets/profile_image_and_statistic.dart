import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/features/designer_profile/presentation/getx/getData_controller_getx.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/widgets/circle_avatar_custom.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/widgets/numbers_of_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileImageAndStatistic extends StatelessWidget {
  ProfileImageAndStatistic({super.key});
  final controller = Get.find<GetDataControllerGetx>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatarCustom(),
            Positioned(
              right: 110.r,
              top: 5.r,
              child: Obx(() => Skeletonizer(
                    enabled: controller.isLoading.value,
                    child: controller.designerR.value == null
                        ? Text("لا نوجد بيانات")
                        : Text(
                            controller.designerR.value!.user.name,
                            style: AppStyles.headingSmall,
                          ),
                  )),
            ),
            Positioned(
              right: 140.r,
              top: 40.r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Skeletonizer(
                      enabled: controller.isLoading.value,
                      child: NumbersOfProfile(
                        field: 'الأعمال',
                        number:
                            "${controller.designerR.value?.worksCount ?? 0}",
                      ),
                    ),
                  ),
                  SizedBox(width: 30.w),
                  Obx(
                    () => Skeletonizer(
                      enabled: controller.isLoading.value,
                      child: NumbersOfProfile(
                        field: 'التقييمات',
                        number:
                            "${controller.designerR.value?.reviewsCount ?? 0}",
                      ),
                    ),
                  ),
                  SizedBox(width: 30.w),
                  Obx(
                    () => Skeletonizer(
                      enabled: controller.isLoading.value,
                      child: NumbersOfProfile(
                        field: 'الطلبات',
                        number:
                            "${controller.designerR.value?.worksCount ?? 0}",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              /// this bio
              top: 85.r,
              right: 105.r,
              child: Container(
                height: 20.h,
                width: 230.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: AppColors.primaryColor.withValues(alpha: 0.5),
                ),
                child: Center(
                  child: Obx(
                    () => Skeletonizer(
                      enabled: controller.isLoading.value,
                      child: Text(
                        controller.designerR.value?.specialization ?? "none",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
