import 'package:cached_network_image/cached_network_image.dart';
import 'package:designers_platform/core/utils/app_image.dart';
import 'package:designers_platform/features/home/presentation/getx/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class DesignerHeader extends StatelessWidget {
  const DesignerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Obx(() {
            final avatar = c.user.value?.avatarUrl;

            return CircleAvatar(
              radius: 28.r,
              backgroundImage: (avatar != null && avatar.isNotEmpty)
                  ? CachedNetworkImageProvider(avatar)
                  : const AssetImage(AppImage.icon1),
            );
          }),
          SizedBox(width: 12.w),
          Obx(() {
            var designer = c.designer.value;
            return Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'مرحبًا، ${c.user.value?.name} 👋',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    designer?.specialization ?? '',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
    );
  }
}
