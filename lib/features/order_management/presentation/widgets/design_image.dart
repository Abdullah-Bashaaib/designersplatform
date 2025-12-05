import 'package:cached_network_image/cached_network_image.dart';
import 'package:designers_platform/features/order_management/presentation/pages/view_completed_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DesignImage extends StatelessWidget {
  final String imageUrl;
  const DesignImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.to(() => ViewCompletedOrder(imageUrl: imageUrl));
      },
      icon: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: imageUrl.isEmpty
            ? Container(
                width: 80.w,
                height: 80.w,
                color: Colors.grey.shade300,
                child: Icon(Icons.image_not_supported,
                    color: Colors.grey.shade600),
              )
            : CachedNetworkImage(
                imageUrl: imageUrl,
                width: 80.w,
                height: 80.w,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
