import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/widget/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData? prefixIcon;
  final String label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final String? Function(String?)? onChange;
  final int? maxLines;
  const BuildTextField({
    super.key,
    this.controller,
    this.hintText = '',
    this.prefixIcon,
    this.label = '',
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.maxLines = 1,
    this.onSaved,
    this.onChange,
  });

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
        widget.label == ''
            ? Gap(
                height: 0.1.h,
              )
            : Text(widget.label, style: AppStyles.headingSmall),
        Gap(height: 5.h),
        Padding(
          padding: EdgeInsets.only(bottom: 8.r, right: 8.r, left: 8.r),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            decoration: AppStyles.getInputDecoration(
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon,
              prefixIcon: Icon(widget.prefixIcon),
            ),
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
