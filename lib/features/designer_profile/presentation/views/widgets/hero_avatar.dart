import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      child: Stack(clipBehavior: Clip.none, children: [
        CircleAvatar(
          radius: 70.r,
          backgroundColor: Colors.grey.shade200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(150.r),
            child: controller.designerR.value?.user.avatarUrl != null
                ? Image.network(
                    controller.designerR.value!.user.avatarUrl!,
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
                        AppImage.icon1,
                        fit: BoxFit.cover,
                        width: 140.w,
                        height: 140.h,
                      );
                    },
                  )
                : Image.asset(
                    AppImage.icon1,
                    fit: BoxFit.cover,
                    width: 140.w,
                    height: 140.h,
                  ),
          ),
        ),
        Positioned(
            top: 100.r,
            child: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                child: Icon(Icons.photo_camera_back_outlined),
              ),
            )),
      ]),
    );
  }
}
