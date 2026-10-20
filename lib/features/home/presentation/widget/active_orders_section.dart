import 'package:designers_platform/features/home/presentation/getx/home_controller.dart';
import 'package:designers_platform/features/home/presentation/widget/section_title.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ActiveOrdersSection extends StatelessWidget {
  const ActiveOrdersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: 'الطلبات النشطة'),
          SizedBox(height: 12.h),
          c.activateOrders.isEmpty
              ? Center(
                  child: Text('لا توجد طلبات نشطة'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: c.activateOrders.length,
                  itemBuilder: (context, index) {
                    final o = c.activateOrders[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _OrderCard(
                        order: o,
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final OrderEntity order;

  const _OrderCard({required this.order});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.grey.shade900,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.designerName,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4.h),
                Text(order.clientName,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
              ],
            ),
          ),
          Column(
            children: [
              Text('3 أيام',
                  style: TextStyle(fontSize: 12.sp, color: Colors.orange)),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
