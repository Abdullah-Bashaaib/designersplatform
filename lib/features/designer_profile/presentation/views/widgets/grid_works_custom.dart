import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/widget/custom_text.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/designer_profile/presentation/getx/getData_controller_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/app_image.dart';

class GridWorksCustom extends StatelessWidget {
  final Designer? currentDesigner;
  GridWorksCustom({super.key, this.currentDesigner});
  final controller = Get.find<GetDataControllerGetx>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              child: Padding(
                padding: EdgeInsets.only(top: 8.r),
                child: Row(
                  children: [
                    Icon(Icons.work_outline_rounded),
                    SizedBox(width: 5),
                    Text("أعمالـــــــي", style: AppStyles.headingSmall),
                  ],
                ),
              ),
            ),
          ],
        ),

        /// 👇 هنا فقط الجزء المتغير
        Obx(() {
          final designer = currentDesigner ?? controller.designerR.value;
          return Skeletonizer(
            enabled: controller.isLoading.value,
            child: designer?.worksCount == null || designer?.worksCount == 0
                ? Container(
                    margin: EdgeInsets.only(top: 90.r),
                    child: Column(
                      children: [
                        Icon(
                          Icons.not_interested_rounded,
                          size: 150.sp,
                          color: Theme.of(context)
                              .highlightColor
                              .withValues(alpha: 0.2),
                        ),
                        CustomText(text: "لا توجد أعمـــال !!"),
                      ],
                    ))
                : Container(
                    margin: EdgeInsets.only(top: 10.r),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemCount: designer?.worksCount,
                      itemBuilder: (context, index) {
                        // return Container(
                        //   decoration: BoxDecoration(color: Colors.grey[700]),
                        //   child: Image.network(
                        //     designer!.workList![index].imageUrl,
                        //     fit: BoxFit.cover,
                        //     loadingBuilder: (context, child, loadingProgress) {
                        //       if (loadingProgress == null) return child;
                        //       return Center(
                        //         child: SizedBox(
                        //           width: 30.r,
                        //           height: 30.r,
                        //           child: CircularProgressIndicator(
                        //             strokeWidth: 2.w,
                        //             color: AppColors.primaryColor,
                        //             value: loadingProgress.expectedTotalBytes !=
                        //                     null
                        //                 ? loadingProgress
                        //                         .cumulativeBytesLoaded /
                        //                     (loadingProgress
                        //                             .expectedTotalBytes ??
                        //                         1)
                        //                 : null,
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //     errorBuilder: (context, error, stackTrace) {
                        //       return Image.asset(
                        //         AppImage.profileImage,
                        //         fit: BoxFit.cover,
                        //         width: 100.w,
                        //         height: 100.h,
                        //       );
                        //     },
                        //   ),
                        // );
                      },
                    ),
                  ),
          );
        }),
      ],
    );
  }
}
