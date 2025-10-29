import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widget/custom_card.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/gap.dart';
import '../getx/chat_getx.dart';

Widget buildChatView(ChatOrderGetX controller) {
  return CustomScrollView(
    controller: controller.scrollController,
    // reverse: true, // ننصح بتفعيل هذا في الشات الحقيقي
    slivers: [
      const SliverToBoxAdapter(
        child: CustomCard(order: "نص الطلب"),
      ),
      SliverList.separated(
        itemCount: controller.chatMessages.length,
        itemBuilder: (context, index) {
          bool isMe = index % 2 == 0;
          return Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 16.sp),
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: isMe ? AppColors.primaryColor : Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: CustomText(
                text: controller.chatMessages[index],
                color: isMe ? Colors.white : Colors.black87,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Gap(
          height: 5.h,
        ),
      ),
    ],
  );
}
