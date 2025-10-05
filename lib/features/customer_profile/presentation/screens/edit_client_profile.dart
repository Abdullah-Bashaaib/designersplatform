import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/utils/app_image.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/widget/build_text_field.dart';
import 'package:designers_platform/core/widget/validators.dart';
import 'package:designers_platform/features/customer_profile/presentation/getx/client_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditClientProfile extends StatelessWidget {
  const EditClientProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ClientProfileController>();
    c.getProfile();
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            // color: Colors.black
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'تحديث الملف الشخصي',
          style: TextStyle(
              // color: Colors.black,
              fontSize: 18.sp),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Picture
            Stack(
              children: [
                Obx(
                  () => CircleAvatar(
                    radius: 50.r,
                    backgroundImage: c.avatarUrl.value != null
                        ? NetworkImage(c.avatarUrl.value!)
                        : AssetImage(AppImage.profileImage),
                  ),
                ),
                Positioned(
                  top: 51,
                  left: 40,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        size: 20.sp,
                      ),
                      onPressed: () {
                        c.addAvatar();
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),

            // Username Field

            BuildTextField(
              controller: c.userName.value,
              label: 'اسم المستخدم',
              prefixIcon: Icons.person_outline,
            ),
            SizedBox(height: 20.h),

            // Email/Phone Field
            BuildTextField(
              controller: c.email.value,
              label: 'الايميل',
              prefixIcon: Icons.email_outlined,
              validator: Validators.email,
            ),
            SizedBox(height: 20.h),

            // Account Linked With
            _buildAccountLinked(),

            SizedBox(height: 40.h),

            // Save Changes Button
            ElevatedButton(
              onPressed: () {},
              style: AppStyles.primaryButtonStyle,
              child: Text(
                'حفظ التغيرات',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountLinked() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Liked With',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
                // bottom: BorderSide(color: Colors.grey[300]!),
                ),
          ),
          child: Row(
            children: [
              // Image.asset(
              //   , // Add Google logo asset
              //   width: 24,
              //   height: 24,
              // ),
              SizedBox(width: 16.w),
              Text(
                'Google',
                style: TextStyle(fontSize: 16.sp),
              ),
              Spacer(),
              Icon(
                Icons.link,
                color: Colors.grey,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
