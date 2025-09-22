import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../getx/getData_controller_getx.dart';

class CircleAvatarCustom extends StatelessWidget {
  CircleAvatarCustom({super.key});

  final controller = Get.find<GetDataControllerGetx>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Hero(
            tag: "Avatar",
            child: CircleAvatar(
              radius: 50.r,
              backgroundColor: Colors.grey.shade200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.r),
                child: controller.designer.value?.user.avatarUrl != null
                    ? Image.network(
                        controller.designer.value!.user.avatarUrl!,
                        fit: BoxFit.cover,
                        width: 100.w,
                        height: 100.h,
                        // هنا نحط اللودر
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: SizedBox(
                              width: 30.r,
                              height: 30.r,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.w,
                                color: AppColors.primaryColor,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppImage.icon1,
                            fit: BoxFit.cover,
                            width: 100.w,
                            height: 100.h,
                          );
                        },
                      )
                    : Image.asset(
                        AppImage.icon1,
                        fit: BoxFit.cover,
                        width: 100.w,
                        height: 100.h,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
