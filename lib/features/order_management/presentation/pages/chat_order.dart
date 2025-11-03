import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/order_management/presentation/getx/order_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/widget/custom_text.dart';
import '../../domain/usecase/chat_room/get_chat_messages_usecase.dart';
import '../../domain/usecase/chat_room/send_message_useCase.dart';
import '../getx/chat_getx.dart';
import '../widgets/build_chat_view.dart';
import '../widgets/build_initial_view.dart';
import '../widgets/build_text_field_chat.dart';

class ChatOrder extends StatelessWidget {
  final OrderEntity order;
  ChatOrder({super.key, required this.order});
  // final controller = Get.find<ChatOrderGetX>();
  final c = Get.find<OrderGetx>();

  @override
  Widget build(BuildContext context) {
    final ChatOrderGetX controller = Get.put(
      ChatOrderGetX(
        order: order,
        Get.find<SharedPreferences>(),
        Get.find<GetChatMessagesUseCase>(),
        Get.find<SendMessageUseCase>(),
        Get.find<Uuid>(),
      ),
    );
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(text: order.clientName),
        ),
        body: Obx(
          () => Column(
            children: [
              Expanded(
                child: controller.isOrderAccepted
                    ? buildChatView(controller, order)
                    : buildInitialView(controller, context, order, c),
              ),
              if (controller.isOrderAccepted) BuildTextFieldChat(),
            ],
          ),
        ),
      ),
    );
  }
}
