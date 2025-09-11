import 'package:flutter/material.dart';

class CircleAvatarCustom extends StatelessWidget {
  const CircleAvatarCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(100),
            child: Image.asset(
                fit: BoxFit.fill, "assets/icons/image_profile01.png"),
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
