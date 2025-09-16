import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesList extends StatelessWidget {
  final List<Map<String, dynamic>> favorites = [
    {"icon": Icons.person, "name": "عبدالله"},
    {"icon": Icons.person, "name": "محمد"},
    {"icon": Icons.person, "name": "أحمد"},
    {"icon": Icons.person, "name": "خالد"},
    {"icon": Icons.person, "name": "ليلى"},
  ];

  FavoritesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h, // ارتفاع الصف
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final fav = favorites[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(
                    fav["icon"],
                    size: 28.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  fav["name"],
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
