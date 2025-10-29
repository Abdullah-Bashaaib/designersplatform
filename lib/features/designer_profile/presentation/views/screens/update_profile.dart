import 'package:designers_platform/features/designer_profile/presentation/getx/getData_controller_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
                  Row(
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
                  Row(
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
