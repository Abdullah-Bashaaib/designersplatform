import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widget/custom_text.dart';
import '../../domain/entity/orders.dart';
import '../../domain/repo/i_chat_repository.dart';
import '../bindings/chat_binding.dart';
import '../getx/chat_getx.dart';
import '../widgets/build_chat_view.dart';
import '../widgets/build_initial_view.dart';
import '../widgets/build_text_field_chat.dart';

class ChatOrder extends StatefulWidget {
  const ChatOrder({super.key});

  @override
  State<ChatOrder> createState() => _ChatOrderState();
}

class _ChatOrderState extends State<ChatOrder> {
  final OrderEntity order = Get.arguments as OrderEntity;
  late final ChatController controller;

  @override
  void initState() {
    super.initState();

    if (!Get.isRegistered<ChatRepository>()) {
      ChatBinding().dependencies();
    }

    controller = Get.find<ChatController>();

    if (order.status == 'مقبول') {
      controller.initChat(
        orderId: order.id,
        clientId: order.clientId,
        designerId: order.designerId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isAccepted = order.status == 'مقبول';

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(text: order.clientName),
        ),
        body: isAccepted
            ? Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  children: [
                    Expanded(
                      child: buildChatView(controller, order),
                    ),
                    BuildTextFieldChat(
                      chatId: order.id,
                    ),
                  ],
                );
              })
            : BuildInitialView(order: order),
      ),
    );
  }
}
