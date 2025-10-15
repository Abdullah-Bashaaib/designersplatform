import 'package:cached_network_image/cached_network_image.dart';
import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../getx/getData_controller_getx.dart';

class CircleAvatarCustom extends StatelessWidget {
  final String? currentAvatarUrl;
  CircleAvatarCustom({super.key, this.currentAvatarUrl});

  final controller = Get.find<GetDataControllerGetx>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "Avatar",
          child: Obx(() {
            final avatarUrl = controller.designerR.value?.avatarUrl;
            return CircleAvatar(
              radius: 50.r,
              backgroundColor: Colors.grey.shade200,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: Skeletonizer(
                    enabled: controller.isLoading.value,
                    child: avatarUrl != null
                        ? CachedNetworkImage(
                            imageUrl: (currentAvatarUrl ?? avatarUrl).isNotEmpty
                                ? "${currentAvatarUrl ?? avatarUrl}?v=${DateTime.now().millisecondsSinceEpoch}"
                                : AppImage.icon1,
                            fit: BoxFit.cover,
                            width: 140.w,
                            height: 140.h,
                            placeholder: (context, url) => Center(
                              child: SizedBox(
                                width: 30.r,
                                height: 30.r,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.w,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              AppImage.icon1,
                              fit: BoxFit.cover,
                              width: 140.w,
                              height: 140.h,
                            ),
                          )
                        : Image.asset(
                            AppImage.icon1,
                            fit: BoxFit.cover,
                            width: 100.w,
                            height: 100.h,
                          ),
                  )),
            );
          }),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
