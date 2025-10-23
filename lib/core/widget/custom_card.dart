import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_button.dart';
import 'custom_outline_button.dart';
import 'custom_text.dart';
import 'gap.dart';

class CustomCard extends StatelessWidget {
  final String order;
  const CustomCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Column(
          children: [
            ListTile(
              title: CustomText(text: order),
              subtitle: CustomText(text: "تفاصيل الطلب"),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {},
                    text: "قبول",
                  ),
                ),
                Gap(width: 10.w),
                CustomOutlineButton(
                  onPressed: () {},
                  text: "رفض",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
