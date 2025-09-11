import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/widgets/circle_avatar_custom.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/widgets/numbers_of_profile.dart';
import 'package:flutter/material.dart';

class ProfileImageAndStatistic extends StatelessWidget {
  const ProfileImageAndStatistic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatarCustom(),
            Positioned(
              right: 110,
              top: 5,
              child: const Text(
                "علي أحمد النوبي",
                style: AppStyles.headingSmall,
              ),
            ),
            Positioned(
              right: 140,
              top: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumbersOfProfile(field: 'الاعمال', number: '250K'),
                  const SizedBox(
                    width: 30,
                  ),
                  NumbersOfProfile(field: 'التقييمات', number: '650K'),
                  const SizedBox(
                    width: 30,
                  ),
                  NumbersOfProfile(field: 'الطلبات', number: '750K'),
                ],
              ),
            ),
            Positioned(
              top: 85,
              right: 105,
              child: Container(
                height: 20,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.primaryColor.withValues(alpha: 0.5),
                ),
                child: const Center(
                  child: Text(
                    "مصمم جرافيك - UI/UX",
                    style: TextStyle(
                      fontSize: 10,
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
