import 'package:designers_platform/core/widget/build_text_field.dart';
import 'package:designers_platform/core/widget/custom_text.dart';
import 'package:designers_platform/core/widget/gap.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/order_management/presentation/getx/order_getx.dart';
import 'package:designers_platform/features/order_management/presentation/pages/chat_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/format_date.dart';

class ViewOrder extends StatefulWidget {
  const ViewOrder({super.key});

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  final TextEditingController _searchController = TextEditingController();
  List<String> filteredOrders = [];
  final c = Get.find<OrderGetx>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(text: "الطلبات"),
          actions: [
            Obx(() {
              return IconButton(
                iconSize: 24.sp,
                icon: c.isLoading.value
                    ? Container(
                        height: 24.h,
                        width: 24.w,
                        padding: EdgeInsets.all(3.r), // تبسيط
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary, // استخدام الثيم
                        ),
                      )
                    : Icon(Icons.refresh), // تبسيط
                onPressed: () {
                  if (!c.isLoading.value) {
                    c.getOrders();
                  }
                },
              );
            }),
          ],
        ),
        body: Obx(() {
          // 1. أولاً، تحقق من الحالة الفارغة (فقط إذا انتهى التحميل)
          if (!c.isLoading.value && c.orderList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.not_interested_rounded,
                    size: 200.5.sp,
                    color:
                        Theme.of(context).highlightColor.withAlpha(50), // تبسيط
                  ),
                  CustomText(text: "لا توجـــــد طلبـــــات !", size: 20),
                ],
              ),
            );
          }

          // 2. إذا كان هناك بيانات (أو لا يزال يحمل)، اعرض القائمة
          return CustomScrollView(
            slivers: [
              // 🔍 مربع البحث
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0.r),
                      child: BuildTextField(
                        controller: _searchController,
                        onChange: null,
                        hintText: 'ابحث عن طلب...',
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                    Gap(height: 10.h),
                  ],
                ),
              ),

              // 🧾 القائمة (هنا الإصلاح)
              SliverSkeletonizer(
                enabled:
                    c.isLoading.value, // شغّل الـ Skeleton فقط أثناء التحميل
                child: SliverList.separated(
                  // إذا كان يحمل، اعرض 10 عناصر وهمية
                  // إذا انتهى التحميل، اعرض العدد الحقيقي
                  itemCount: c.isLoading.value ? 9 : c.orderList.length,
                  separatorBuilder: (context, index) => Divider(
                    thickness: 0.1,
                    height: 0.5,
                  ),
                  itemBuilder: (context, index) {
                    // --- لا نستخدم Skeletonizer هنا ---

                    // إذا كان يحمل، لا تحاول الوصول لبيانات (order)
                    if (c.isLoading.value) {
                      return ListTile(
                        leading: CircleAvatar(),
                        title: CustomText(text: "اسم العميل..."),
                        subtitle: CustomText(
                            text: "تفاصيل الطلبkkkkkkkkkkkkkkkkkkkkkkkk..."),
                      );
                    }

                    // --- الكود الأصلي (فقط إذا لم يكن يحمل) ---
                    final order = c.orderList[index];
                    return Dismissible(
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 28),
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.delete, color: Colors.white),
                            const CustomText(text: "حذف", color: Colors.white)
                          ],
                        ),
                      ),
                      key: ValueKey<OrderEntity>(order),
                      child: ListTile(
                        onTap: () {
                          Get.to(
                            () => ChatOrder(
                              order: order,
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          child: CustomText(
                            text: order.clientName.substring(0, 1),
                          ),
                        ),
                        title: CustomText(text: order.clientName),
                        subtitle: CustomText(
                            text: order.description == ''
                                ? 'لا يوجد وصف'
                                : order.description!),
                        trailing: CustomText(
                          text: formatStyleDate(order.createAt, 'ar'),
                        ),
                      ),
                      onDismissed: (DismissDirection direction) {},
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
