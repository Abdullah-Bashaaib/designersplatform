import 'package:designers_platform/features/home/presentation/widget/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveOrdersSection extends StatelessWidget {
  const ActiveOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: 'الطلبات النشطة'),
          SizedBox(height: 12.h),
          _OrderCard(),
          SizedBox(height: 10.h),
          _OrderCard(),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.grey.shade900,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('تصميم تطبيق موبايل',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4.h),
                Text('العميل: محمد',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
          Column(
            children: [
              Text('3 أيام',
                  style: TextStyle(fontSize: 12.sp, color: Colors.orange)),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
