import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class BioCustom extends StatelessWidget {
  const BioCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "السيرة الذاتية",
          style: AppStyles.headingSmall,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "مصمم جرافيك محترف بخبرة تزيد عن 5 سنوات في تصميم الشعارات والهوية البصرية.",
          style: AppStyles.bodySmall,
        ),
      ],
    );
  }
}
