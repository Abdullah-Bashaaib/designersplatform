import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/utils/app_image.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/customer_profile/presentation/getx/client_profile_controller.dart';
import 'package:designers_platform/features/customer_profile/presentation/screens/edit_client_profile.dart';
import 'package:designers_platform/features/customer_profile/presentation/screens/view_order.dart';
import 'package:designers_platform/features/customer_profile/presentation/screens/widget/favorites_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ClientProfileController>();
    c.getProfile();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'الملف الشخصي',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'orders') {
                Get.to(() => ViewOrders());
              } else if (value == 'settings') {
                // Get.to(() => );
              } else if (value == 'logout') {
                c.logout();
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'orders',
                child: Row(
                  children: [
                    Icon(Icons.shopping_cart),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text('طلباتي')
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text('الاعدادات')
                  ],
                ),
              ),
              PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text('تسجيل الخروج')
                    ],
                  ))
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 55.r,
                backgroundColor: Colors.blueAccent.withOpacity(0.2),
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundImage: CurrentUser.currentUser!.avatarUrl != ''
                      ? NetworkImage(CurrentUser.currentUser!.avatarUrl!)
                      : AssetImage(AppImage.profileImage),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text('اسم المستخدم:'),
            SizedBox(
              height: 5.h,
            ),
            Obx(
              () => Text(
                c.userName.value.text,
                textAlign: TextAlign.right,
                style: TextStyle(),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text('الايميل:'),
            SizedBox(
              height: 5.h,
            ),
            Obx(
              () => Text(
                c.email.value.text,
                textAlign: TextAlign.right,
                style: TextStyle(),
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => EditClientProfile());
                },
                style: AppStyles.primaryButtonStyle,
                child: Text(
                  "تعديل الملف الشخصي",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Divider(),
            Text('المفضلة:'),
            SizedBox(
              height: 20.h,
            ),
            Obx(
              () => c.favoritesList.isNotEmpty
                  ? FavoritesList()
                  : Center(
                      child: Text(emptyFavoritesListMessage),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
