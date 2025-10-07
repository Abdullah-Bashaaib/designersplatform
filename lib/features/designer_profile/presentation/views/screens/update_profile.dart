import 'package:designers_platform/features/designer_profile/presentation/getx/getData_controller_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../widgets/hero_avatar.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({super.key});
  final GetDataControllerGetx controller = Get.find<GetDataControllerGetx>();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _specializationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var designer = controller.designerR.value!;
    _nameController.text = designer.name;
    _bioController.text = designer.bio ?? "لا توجد بيانات";
    _specializationController.text =
        designer.specialization ?? "لا توجد بيانات";
    return Scaffold(
      appBar: AppBar(
        title: Text("تعديل الملف الشخصي"),
      ),
      body: SingleChildScrollView(
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
              /// name
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 5.r),
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
                  TextField(
                    controller: _nameController,
                  ),
                ],
              ),
            ),
            Padding(
              /// specialization
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 5.r),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        top: 15.r,
                        child: Container(
                          width: 125.r,
                          height: 10.r,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: AppStyles.mediumRadius,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.free_breakfast),
                          SizedBox(
                            width: 10.r,
                          ),
                          Text(
                            "التخصص",
                            style: AppStyles.headingSmall,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.r,
                  ),
                  TextField(controller: _specializationController)
                ],
              ),
            ),
            Padding(
              /// bio
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 15.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: 10.r, bottom: 20.r),
                          width: 150.w,
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
                    controller: _bioController,
                    maxLines: 5,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: AppStyles.secondaryButtonStyle,
                  onPressed: () {
                    designer.name = _nameController.text;
                    designer.bio = _bioController.text;
                    designer.specialization = _specializationController.text;
                    controller.updateDesigner(designer);
                    Get.back();
                  },
                  child: Text("تعديل"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
