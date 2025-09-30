import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/features/designer_profile/presentation/getx/add_update_delete_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/hero_avatar.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({super.key});
  final controller = Get.find<AddUpdateDeleteGetx>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تعديل الملف الشخصي"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          HeroAvatar(controller: controller),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 10.r, bottom: 20.r, right: 10.r),
                        width: 90.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: AppStyles.mediumRadius,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 15.r,
                      bottom: 14.r,
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "الاسم",
                            style: AppStyles.headingSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TextField(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 5.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      child: Container(
                        margin: EdgeInsets.only(top: 10.r, bottom: 20.r),
                        width: 140.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: AppStyles.mediumRadius,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 15.r,
                      child: Row(
                        children: [
                          Icon(Icons.info_outline_rounded),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "السيرة الذاتية",
                            style: AppStyles.headingSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TextField(
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
