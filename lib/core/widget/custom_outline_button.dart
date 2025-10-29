import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'custom_text.dart';

class CustomOutlineButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final Color colorText;
  const CustomOutlineButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.colorText = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: AppStyles.secondaryButtonStyle,
      onPressed: onPressed,
      child: CustomText(
        text: text,
        color: colorText,
      ),
    );
  }
}
