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
      body: Center(
        child: Column(
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
              child: TextField(
                decoration: InputDecoration(
                    labelText: "الاسم", labelStyle: AppStyles.headingSmall),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 5.r),
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: "السيرة الذاتية",
                    labelStyle: AppStyles.headingSmall),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
