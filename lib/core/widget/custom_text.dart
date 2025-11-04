import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

enum TextStyleEnum {
  headingLarge,
  headingMedium,
  headingSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  caption,
}

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final int? maxLines;
  final TextAlign? align;
  final TextOverflow? overflow;
  final TextStyleEnum? style;

  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.maxLines,
    this.align,
    this.overflow,
    this.style, // لاحظ أنه اختياري الآن
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: align,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: _resolveStyle().copyWith(
        color: color,
        fontSize: size,
      ),
    );
  }

  TextStyle _resolveStyle() {
    switch (style) {
      case TextStyleEnum.headingLarge:
        return AppStyles.headingLarge;
      case TextStyleEnum.headingMedium:
        return AppStyles.headingMedium;
      case TextStyleEnum.headingSmall:
        return AppStyles.headingSmall;
      case TextStyleEnum.bodyLarge:
        return AppStyles.bodyLarge;
      case TextStyleEnum.bodyMedium:
        return AppStyles.bodyMedium;
      case TextStyleEnum.bodySmall:
        return AppStyles.bodySmall;
      case TextStyleEnum.caption:
        return AppStyles.caption;
      default:
        return const TextStyle(
          fontSize: 16,
        );
    }
  }
}
