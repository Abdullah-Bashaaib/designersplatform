import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widget/custom_text.dart';
import '../getx/chat_getx.dart';
import '../widgets/build_chat_view.dart';
import '../widgets/build_initial_view.dart';
import '../widgets/build_text_field_chat.dart';

class ChatOrder extends StatelessWidget {
  const ChatOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatOrderGetX>();

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const CustomText(text: "هنا اسم العميل (GetX)"),
        ),
        body: Obx(
          () => Column(
            children: [
              Expanded(
                child: controller.isOrderAccepted
                    ? buildChatView(controller)
                    : buildInitialView(controller, context),
              ),
              if (controller.isOrderAccepted) const BuildTextFieldChat(),
            ],
          ),
        ),
      ),
    );
  }
}
