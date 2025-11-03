import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DesignImage extends StatelessWidget {
  final String imageUrl;
  const DesignImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: imageUrl.isEmpty
          ? Container(
              width: 80.w,
              height: 80.w,
              color: Colors.grey.shade300,
              child:
                  Icon(Icons.image_not_supported, color: Colors.grey.shade600),
            )
          : Image.network(
              imageUrl,
              width: 80.w,
              height: 80.w,
              fit: BoxFit.cover,
            ),
    );
  }
}
