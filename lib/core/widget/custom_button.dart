import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final Color color;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: AppStyles.secondaryButtonStyle,
      onPressed: onPressed,
      child: CustomText(
        text: text,
        color: Colors.white,
      ),
    );
  }
}
