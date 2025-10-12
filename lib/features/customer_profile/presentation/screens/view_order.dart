import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/customer_profile/presentation/getx/client_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class ViewOrders extends StatelessWidget {
  const ViewOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ClientProfileController>();
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
          padding: EdgeInsets.all(12.w),
          child: Obx(
            () => c.orderList.isEmpty
                ? Center(child: Text(emptyOrdersMessage))
                : ListView.separated(
                    itemCount: c.orderList.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final order = c.orderList[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        elevation: 4,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.r),
                                bottomLeft: Radius.circular(16.r),
                              ),
                              child: Image.network(
                                order.imageUrl!,
                                width: 100.w,
                                height: 100.h,
                                fit: BoxFit.cover,
                              ),
                            ),

                            SizedBox(width: 12.w),

                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order.designerName,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      "معرف المصمم: ${order.designerId}",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // زر للعرض أو التفاصيل
                            IconButton(
                              onPressed: () {
                                // TODO: Add navigation to order details page
                              },
                              icon: Icon(Icons.arrow_forward_ios, size: 18.sp),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          )),
    );
  }
}
