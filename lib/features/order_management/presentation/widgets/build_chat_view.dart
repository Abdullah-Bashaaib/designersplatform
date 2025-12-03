import 'dart:developer';

import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widget/custom_card.dart';
import '../../../../core/widget/gap.dart';
import '../getx/chat_getx.dart';

Widget buildChatView(ChatOrderGetX controller, OrderEntity order) {
  return CustomScrollView(
    controller: controller.scrollController,
    // reverse: true, // ننصح بتفعيل هذا في الشات الحقيقي
    slivers: [
      SliverToBoxAdapter(
        child: CustomCard(
          order: order.designType,
          orderDescription:
              order.description == '' ? 'لا يوجد وصف' : order.description!,
        ),
      ),
      SliverList.separated(
        itemCount: controller.chatMessages.length,
        itemBuilder: (context, index) {
          // --- 1. احصل على كائن الرسالة أولاً ---
          final message = controller.chatMessages[index];
          log("message: message is ${message.content}");

          // --- 2. اسأل الكنترولر "هل هذه الرسالة مني؟" ---
          bool isMe = controller.isMessageFromMe(message);

          // (باقي الكود كما هو، الآن سيعمل بشكل صحيح)
          return Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 16.sp),
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: isMe ? AppColors.primaryColor : Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                  // --- 3. اعرض محتوى الرسالة ---
                  message.content,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black87,
                  )),
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
