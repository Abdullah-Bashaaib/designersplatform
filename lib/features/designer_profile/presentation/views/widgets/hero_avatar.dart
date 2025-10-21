import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_image.dart';
import '../../getx/getData_controller_getx.dart';

class HeroAvatar extends StatelessWidget {
  const HeroAvatar({
    super.key,
    required this.controller,
  });

  final GetDataControllerGetx controller;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "Avatar",
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Obx(() {
            final avatarUrl = controller.designerR.value?.avatarUrl;
            return CircleAvatar(
              radius: 70.r,
              backgroundColor: Colors.grey.shade200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150.r),
                child: Skeletonizer(
                  enabled: controller.isLoading.value,
                  child: avatarUrl != null
                      ? CachedNetworkImage(
                          imageUrl: avatarUrl,
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
                          width: 140.w,
                          height: 140.h,
                        ),
                ),
              ),
            );
          }),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: controller.editAvatar,
              child: CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.primaryColor,
                child:
                    Icon(Icons.photo_camera, color: Colors.white, size: 20.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
