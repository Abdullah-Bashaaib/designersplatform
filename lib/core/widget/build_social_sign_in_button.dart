import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class BuildSocialSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final Color backgroundColor;

  const BuildSocialSignInButton(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.icon,
      required this.backgroundColor,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: AppStyles.primaryButtonStyle,
      ),
    );
  }
}
