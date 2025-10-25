import 'package:designers_platform/core/widget/build_text_field.dart';
import 'package:designers_platform/core/widget/custom_text.dart';
import 'package:designers_platform/core/widget/gap.dart';
import 'package:designers_platform/features/order_management/presentation/pages/chat_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewOrder extends StatefulWidget {
  const ViewOrder({super.key});

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  final TextEditingController _searchController = TextEditingController();
  List<String> allOrders = List.generate(100, (i) => "الطلب ${i + 1}");
  List<String> filteredOrders = [];

  @override
  void initState() {
    super.initState();
    filteredOrders = allOrders;
  }

  // void _filterOrders(String query) {
  //   final results = allOrders
  //       .where((order) => order.toLowerCase().contains(query.toLowerCase()))
  //       .toList();
  //   setState(() {
  //     filteredOrders = results;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(text: "الطلبات"),
        ),
        body: CustomScrollView(
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
                      prefixIcon: Icons.search,
                    ),
                  ),
                  Gap(height: 10.h),
                ],
              ),
            ),

            // 🧾 القائمة
            SliverList.separated(
              itemCount: filteredOrders.length,
              separatorBuilder: (context, index) => Divider(
                thickness: 0.1,
                height: 0.5,
              ),
              itemBuilder: (context, index) {
                final order = filteredOrders[index];
                return Dismissible(
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 28),
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        const CustomText(
                          text: "حذف",
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  key: ValueKey<String>(order),
                  child: ListTile(
                    onTap: () {
                      Get.to(() => ChatOrder());
                    },
                    leading: CircleAvatar(
                      child: CustomText(
                        text: order.substring(2, 3),
                      ),
                    ),
                    title: CustomText(text: order),
                    subtitle: CustomText(text: "تفاصيل الطلب حوالي سطر واحد"),
                  ),
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      allOrders.removeAt(index);
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
