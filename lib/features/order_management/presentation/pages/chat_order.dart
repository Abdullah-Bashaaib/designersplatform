import 'package:designers_platform/features/order_management/presentation/getx/order_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widget/custom_text.dart';
import '../getx/chat_getx.dart';
import '../widgets/build_chat_view.dart';
import '../widgets/build_initial_view.dart';
import '../widgets/build_text_field_chat.dart';

class ChatOrder extends StatelessWidget {
  final int index;
  ChatOrder({super.key, required this.index});
  final controller = Get.find<ChatOrderGetX>();
  final c = Get.find<OrderGetx>();

  @override
  Widget build(BuildContext context) {
    final order = c.orderList[index];
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
                    : buildInitialView(controller, context, order),
              ),
              if (controller.isOrderAccepted) const BuildTextFieldChat(),
            ],
          ),
        ),
      ),
    );
  }
}
