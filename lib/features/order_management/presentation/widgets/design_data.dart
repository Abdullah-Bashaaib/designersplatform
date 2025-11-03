import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DesignData extends StatelessWidget {
  final DateTime createAt;
  DesignData({super.key, required this.createAt});

  final dateFormat = DateFormat('dd MMM yyyy • hh:mm a');

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        dateFormat.format(createAt),
        style: AppStyles.bodySmall,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.end,
      ),
    );
  }
}
