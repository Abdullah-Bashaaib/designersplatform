import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/widgets/circle_avatar_custom.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/widgets/numbers_of_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileImageAndStatistic extends StatelessWidget {
  const ProfileImageAndStatistic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatarCustom(),
            Positioned(
              right: 110.r,
              top: 5.r,
              child: Text(
                "علي أحمد النوبي",
                style: AppStyles.headingSmall,
              ),
            ),
            Positioned(
              right: 140.r,
              top: 40.r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumbersOfProfile(field: 'الاعمال', number: '250K'),
                  SizedBox(
                    width: 30.w,
                  ),
                  NumbersOfProfile(field: 'التقييمات', number: '650K'),
                  SizedBox(
                    width: 30.w,
                  ),
                  NumbersOfProfile(field: 'الطلبات', number: '750K'),
                ],
              ),
            ),
            Positioned(
              top: 85.r,
              right: 105.r,
              child: Container(
                height: 20.h,
                width: 230.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: AppColors.primaryColor.withValues(alpha: 0.5),
                ),
                child: Center(
                  child: Text(
                    "مصمم جرافيك - UI/UX",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
