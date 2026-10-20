import 'package:designers_platform/core/widget/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widget/custom_card.dart';
import '../../domain/entity/chat_room.dart';
import '../../domain/entity/orders.dart';
import '../getx/chat_getx.dart';

Widget buildChatView(ChatController controller, OrderEntity order) {
  final String? currentUserId = Supabase.instance.client.auth.currentUser?.id;

  return Obx(() {
    final List<ChatMessage> messages = controller.messages;

    return CustomScrollView(
      reverse: true, // مهم جدًا للشات
      slivers: [
        /// --- معلومات الطلب في الأعلى ---

        /// --- لو لا توجد رسائل ---
        if (messages.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text('لا توجد رسائل بعد'),
            ),
          )
        else

          /// --- قائمة الرسائل ---
          SliverList.separated(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final bool isMe =
                  currentUserId != null && message.senderId == currentUserId;

              return Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.primaryColor : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    message.content,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black87,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 6),
          ),
        SliverToBoxAdapter(
          child: CustomCard(
            order: order.designType,
            orderDescription: order.description?.isEmpty ?? true
                ? 'لا يوجد وصف'
                : order.description!,
          ),
        ),
        SliverToBoxAdapter(
          child: const Gap(
            height: 100,
          ),
        )
      ],
    );
  });
}
