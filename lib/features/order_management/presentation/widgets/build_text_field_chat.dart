import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widget/build_text_field.dart';
import '../getx/chat_getx.dart';

class BuildTextFieldChat extends StatefulWidget {
  final String chatId;
  const BuildTextFieldChat({super.key, required this.chatId});

  @override
  State<BuildTextFieldChat> createState() => _BuildTextFieldChatState();
}

class _BuildTextFieldChatState extends State<BuildTextFieldChat> {
  final ChatController controller = Get.find<ChatController>();
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BuildTextField(
      controller: textController,
      hintText: 'اكتب هنا',
      keyboardType: TextInputType.text,
      suffixIcon: IconButton(
        icon: const Icon(Icons.send, color: AppColors.primaryColor),
        onPressed: () async {
          final text = textController.text;
          await controller.sendTextMessage(text);
          textController.clear();
        },
      ),
    );
  }
}
