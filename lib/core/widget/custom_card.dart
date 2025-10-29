import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class CustomCard extends StatelessWidget {
  final String order;
  const CustomCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: ListTile(
            title: CustomText(
              text: order,
              size: 18.sp,
            ),
            subtitle: CustomText(text: "تفاصيل الطلب"),
          ),
        ),
      ),
    );
  }
}
