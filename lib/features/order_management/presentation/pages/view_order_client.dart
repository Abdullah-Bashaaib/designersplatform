import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/order_management/presentation/getx/order_getx.dart';
import 'package:designers_platform/features/order_management/presentation/pages/details_order_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewOrders extends StatelessWidget {
  ViewOrders({super.key});

  final c = Get.find<OrderGetx>();
  final dateFormat = DateFormat('dd MMM yyyy • hh:mm a');

  Color _statusColor(String status) {
    switch (status) {
      case "مكتمل":
        return Colors.green;
      case "قيد الانتظار":
        return Colors.amber;
      case "مرفوض":
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "طلباتي",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Obx(() {
          if (c.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (c.orderList.isEmpty) {
            return Center(
              child: Text(
                emptyOrdersMessage,
                style: AppStyles.bodyLarge,
              ),
            );
          }

          return ListView.separated(
            itemCount: c.orderList.length,
            separatorBuilder: (context, index) => SizedBox(height: 14.h),
            itemBuilder: (context, index) {
              final order = c.orderList[index];

              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: AppStyles.cardDecoration,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // صورة التصميم
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: order.imageUrl == null || order.imageUrl!.isEmpty
                            ? Container(
                                width: 80.w,
                                height: 80.w,
                                color: Colors.grey.shade300,
                                child: Icon(Icons.image_not_supported,
                                    color: Colors.grey.shade600),
                              )
                            : Image.network(
                                order.imageUrl!,
                                width: 80.w,
                                height: 80.w,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(width: 12.w),

                      // تفاصيل الطلب
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.designerName,
                              style: AppStyles.bodyMedium,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              order.designType,
                              style: AppStyles.bodySmall,
                            ),
                            SizedBox(height: 6.h),
                            Row(
                              children: [
                                Icon(Icons.person,
                                    size: 16.sp,
                                    color: AppColors.textSecondary),
                                SizedBox(width: 4.w),
                                Flexible(
                                  child: Text(
                                    order.designerName,
                                    style: AppStyles.bodySmall,
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
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.h, horizontal: 8.w),
                                  decoration: AppStyles.cardDecoration,
                                  child: Text(
                                    order.status,
                                    style: TextStyle(
                                      color: _statusColor(order.status),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    dateFormat.format(order.createAt),
                                    style: AppStyles.bodySmall,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
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
            },
          );
        }),
      ),
    );
  }
}
