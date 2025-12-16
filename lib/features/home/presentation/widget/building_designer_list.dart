import 'package:designers_platform/core/utils/app_image.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/screens/profile_screen.dart';
import 'package:designers_platform/features/home/presentation/getx/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class BuildingDesignerList extends StatelessWidget {
  const BuildingDesignerList({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final designers = c.designerList;
    return SizedBox(
        height: 150.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: designers.length,
          separatorBuilder: (_, __) => SizedBox(width: 12.w),
          itemBuilder: (context, i) {
            final d = designers[i];
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return MaterialButton(
              onPressed: () => Get.to(ProfileScreen(
                currentDesigner: d,
              )),
              child: Container(
                width: 120.w,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCardColor : AppColors.cardColor,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: AppStyles.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16.r)),
                      child: d.avatarUrl != ''
                          ? Image.network(
                              d.avatarUrl!,
                              height: 80.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              AppImage.icon1,
                              height: 80.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      d.name,
                      style: AppStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.textPrimary,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(
                          "${d.averageRating}",
                          style: AppStyles.caption.copyWith(
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
    );
  }
}
