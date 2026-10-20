import 'package:designers_platform/features/customer_profile/presentation/getx/client_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ClientProfileController>();
    c.getFavoritesList();
    return SizedBox(
      height: 100.h, // ارتفاع الصف
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: c.favoritesList.length,
        itemBuilder: (context, index) {
          final fav = c.favoritesList[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(
                    // fav["icon"],
                    Icons.person,
                    size: 28.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  fav.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
