import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final int? maxLines;
  
  const CustomText({
    super.key,
    required this.text,
    this.size,
    this.color,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontFamily: 'iosRounded'),
      maxLines: maxLines ?? 1,
    );
  }
}
