import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatsCardsSection extends StatelessWidget {
  const StatsCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      _StatItem('الأرباح', '1200\$', Icons.attach_money),
      _StatItem('الطلبات', '5', Icons.shopping_bag),
      _StatItem('التقييم', '4.9', Icons.star),
      _StatItem('الزيارات', '320', Icons.visibility),
    ];

    return SizedBox(
      height: 110.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) => _StatCard(item: stats[i]),
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemCount: stats.length,
      ),
    );
  }
}

class _StatItem {
  final String title;
  final String value;
  final IconData icon;
  _StatItem(this.title, this.value, this.icon);
}

class _StatCard extends StatelessWidget {
  final _StatItem item;
  const _StatCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        color: Colors.grey.shade900,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, size: 22.sp),
          const Spacer(),
          Text(item.value,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
          Text(item.title,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
        ],
      ),
    );
  }
}
