import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widget/build_text_field.dart';

class BuildTextFieldChat extends StatelessWidget {
  const BuildTextFieldChat({super.key});

  @override
  Widget build(BuildContext context) {
    // يمكنك استخدام Get.find<ChatOrderController>() هنا للوصول للـ controller
    // final ChatOrderController controller = Get.find();
    return BuildTextField(
      hintText: 'اكتب هنا',
      keyboardType: TextInputType.text,
      suffixIcon: IconButton(
        icon: const Icon(Icons.send, color: AppColors.primaryColor),
        onPressed: () {},
      ),
    );
  }
}
