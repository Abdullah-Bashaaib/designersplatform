import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/order_management/presentation/pages/details_order_client.dart';
import 'package:designers_platform/features/order_management/presentation/widgets/design_data.dart';
import 'package:designers_platform/features/order_management/presentation/widgets/design_image.dart';
import 'package:designers_platform/features/order_management/presentation/widgets/design_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuildCardOrder extends StatelessWidget {
  final OrderEntity order;
  const BuildCardOrder({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        padding: EdgeInsets.all(12.w),
        // color: Theme.of(context).brightness == Brightness.dark
        //     ? AppColors.darkCardColor
        //     : AppColors.cardColor,
        decoration: Theme.of(context).brightness == Brightness.light
            ? AppStyles.cardDecoration
            : AppStyles.darkCardDecoration,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة التصميم
            
            DesignImage(imageUrl: order.imageUrl!),
            SizedBox(width: 12.w),
            // تفاصيل الطلب
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h),
                  Text(
                    order.designType,
                    style: AppStyles.bodySmall,
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(Icons.person,
                          size: 16.sp, color: AppColors.textSecondary),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Text(
                          order.designerName,
                          // style: AppStyles.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      order.status.isEmpty
                          ? SizedBox()
                          : DesignStatus(order: order),
                      SizedBox(
                        width: 10.w,
                      ),
                      DesignData(createAt: order.createAt),
                    ],
                  ),
                ],
              ),
            ),

            // زر التفاصيل
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: IconButton(
                onPressed: () {
                  Get.to(() => DetailsOrderClient(
                        order: order,
                      ));
                },
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
