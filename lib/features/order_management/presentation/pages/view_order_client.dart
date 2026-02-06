import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/core/widget/custom_text.dart';
import 'package:designers_platform/features/order_management/presentation/getx/order_getx.dart';
import 'package:designers_platform/features/order_management/presentation/widgets/build_card_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewClientOrders extends StatelessWidget {
  ViewClientOrders({super.key});

  final c = Get.find<OrderGetx>();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.getOrders();
    });
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "طلباتي",
          style: TextStyleEnum.headingMedium,
        ),
        actions: [
          IconButton(
              onPressed: () {
                c.getOrders();
              },
              icon: Icon(Icons.update))
        ],
        // Text(
        //   "طلباتي",
        //   style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        // ),
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
              return BuildCardOrder(order: order);
            },
          );
        }),
      ),
    );
  }
}
