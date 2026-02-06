import 'package:designers_platform/features/home/presentation/widget/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: 'آخر التقييمات'),
          SizedBox(height: 10.h),
          _ReviewTile(),
          _ReviewTile(),
        ],
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(),
      title: const Text('خدمة ممتازة ⭐⭐⭐⭐⭐'),
      subtitle: const Text('سريع ومتعاون'),
    );
  }
}
