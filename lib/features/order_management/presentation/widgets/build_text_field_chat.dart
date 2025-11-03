import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widget/build_text_field.dart';
import '../getx/chat_getx.dart';

class BuildTextFieldChat extends StatelessWidget {
  BuildTextFieldChat({super.key});
  final controller = Get.find<ChatOrderGetX>();

  @override
  Widget build(BuildContext context) {
    // يمكنك استخدام Get.find<ChatOrderController>() هنا للوصول للـ controller
    return BuildTextField(
      controller: controller.textController,
      hintText: 'اكتب هنا',
      keyboardType: TextInputType.text,
      suffixIcon: IconButton(
        icon: const Icon(Icons.send, color: AppColors.primaryColor),
        onPressed: controller.sendMessage,
      ),
    );
  }
}
