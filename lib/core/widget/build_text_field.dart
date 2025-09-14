import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class BuildTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final IconData? prefixIcon;
  final String label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  const BuildTextField(
      {super.key,
      required this.controller,
      this.hintText,
      this.prefixIcon,
      required this.label,
      this.keyboardType,
      this.suffixIcon,
      this.obscureText = false});

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  TextInputType? keyboardType;

  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppStyles.headingSmall),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          decoration: AppStyles.getInputDecoration(
              hintText: widget.hintText ?? '',
              prefixIcon: Icon(
                widget.prefixIcon,
                // color: Colors.grey,
              ),
              suffixIcon: widget.suffixIcon),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'هذا الحقل مطلوب';
            }
            return null;
          },
        ),
      ],
    );
  }
}
