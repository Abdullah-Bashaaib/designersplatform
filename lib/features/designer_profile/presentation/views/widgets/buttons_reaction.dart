import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ButtonsReaction extends StatelessWidget {
  const ButtonsReaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              width: 165,
              child: FilledButton(
                  style: AppStyles.secondaryButtonStyle,
                  onPressed: () {},
                  child: Text(
                    "طلب خدمة",
                    style: const TextStyle(fontSize: 15),
                  )),
            ),
             Container(
              padding: const EdgeInsets.only(right: 10),
              width: 175,
              child: OutlinedButton(
                  style: AppStyles.secondaryButtonStyle,
                  onPressed: () {},
                  child: Text(
                    "تقييم المصمم",
                    style: TextStyle(fontSize: 15),
                  )),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          width: double.infinity,
          child: OutlinedButton(
            style: AppStyles.secondaryButtonStyle,
            onPressed: () {},
            child: Text("تعديل الملف الشخصي", style: TextStyle(fontSize: 15)),
          ),
        ),
      ],
    );
  }
}
