import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class BuildTextFieldChat extends StatelessWidget {
  const BuildTextFieldChat({super.key});

  @override
  Widget build(BuildContext context) {
    // يمكنك استخدام Get.find<ChatOrderController>() هنا للوصول للـ controller
    // final ChatOrderController controller = Get.find();
    return Container(
      padding: EdgeInsets.all(8.0.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.sp), topRight: Radius.circular(20.sp)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "اكتب رسالتك...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: AppColors.primaryColor),
            onPressed: () {
              // يمكنك استدعاء دالة الإرسال من الـ controller
              // controller.sendMessage();
            },
          ),
        ],
      ),
    );
  }
}
