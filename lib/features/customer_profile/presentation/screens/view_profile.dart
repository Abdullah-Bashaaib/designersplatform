import 'package:cached_network_image/cached_network_image.dart';
import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_image.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/customer_profile/presentation/getx/client_profile_controller.dart';
import 'package:designers_platform/features/order_management/presentation/pages/view_order_client.dart';
import 'package:designers_platform/features/customer_profile/presentation/screens/widget/favorites_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ClientProfileController>();

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
              child: Stack(
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 50.r,
                      backgroundImage: c.avatarUrl.value != ''
                          ? CachedNetworkImageProvider(c.user.value!.avatarUrl!)
                          : AssetImage(AppImage.icon1) as ImageProvider,
                    ),
                  ),
                  Positioned(
                    top: 51.h,
                    left: 40.w,
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
                          DialogHelper.showCustomDialog(
                            customIcon: Icon(
                              Icons.person,
                              color: AppColors.primaryColor,
                            ),
                            title: 'صورة الملف الشخصي',
                            customContent: Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      c.addAvatar();
                                      Get.back();
                                    },
                                    child: Text('تعديل الصورة')),
                                TextButton(
                                  onPressed: () {
                                    c.deleteAvatar();
                                    Get.back();
                                  },
                                  child: Text(
                                    'حذف الصورة',
                                    style:
                                        TextStyle(color: AppColors.errorColor),
                                  ),
                                ),
                              ],
                            ),
                          );
                          // c.addAvatar();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: AppStyles.cardDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'اسم المستخدم:',
                          style: AppStyles.bodyLarge,
                        ),
                        SizedBox(height: 10.h),
                        Obx(
                          () => Text(
                            c.user.value?.name ?? '',
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      c.updateUserName();
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.only(top: 19.h),
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'تغيير',
                      style: AppStyles.headingSmall,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: 400.w,
              height: 80.h,
              padding: EdgeInsetsGeometry.all(8.w),
              decoration: AppStyles.cardDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('الايميل:', style: AppStyles.bodyLarge),
                  SizedBox(
                    height: 5.h,
                  ),
                  Obx(
                    () => Text(
                      c.user.value!.email,
                      textAlign: TextAlign.right,
                      style: TextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Divider(),
            Text(
              'المفضلة:',
              style: AppStyles.headingSmall,
            ),
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
