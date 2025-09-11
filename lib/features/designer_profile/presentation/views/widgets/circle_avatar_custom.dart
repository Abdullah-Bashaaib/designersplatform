import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleAvatarCustom extends StatelessWidget {
  const CircleAvatarCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50.r,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(100.r),
            child: Image.asset(
                fit: BoxFit.fill, "assets/icons/image_profile01.png"),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
      ],
    );
  }
}
