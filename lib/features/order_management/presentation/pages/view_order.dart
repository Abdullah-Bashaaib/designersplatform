import 'package:designers_platform/core/widget/build_text_field.dart';
import 'package:designers_platform/core/widget/custom_button.dart';
import 'package:designers_platform/core/widget/custom_outline_button.dart';
import 'package:designers_platform/core/widget/custom_text.dart';
import 'package:designers_platform/core/widget/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewOrder extends StatefulWidget {
  const ViewOrder({super.key});

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  final TextEditingController _searchController = TextEditingController();
  List<String> allOrders = List.generate(20, (i) => "الطلب ${i + 1}");
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
          body: Padding(
            padding: EdgeInsets.all(8.0.r),
            child: CustomScrollView(
              slivers: [
                // 🔍 مربع البحث
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      BuildTextField(
                        controller: _searchController,
                        onChange: null,
                        hintText: 'ابحث عن طلب...',
                        prefixIcon: Icons.search,
                      ),
                      Gap(height: 10.h),
                    ],
                  ),
                ),

                // 🧾 القائمة
                SliverList.separated(
                  itemCount: filteredOrders.length,
                  separatorBuilder: (context, index) => Gap(height: 8.h),
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Column(
                          children: [
                            ListTile(
                              title: CustomText(text: order),
                              subtitle: CustomText(text: "تفاصيل الطلب"),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    onPressed: () {},
                                    text: "قبول",
                                  ),
                                ),
                                Gap(width: 10.w),
                                CustomOutlineButton(
                                  onPressed: () {},
                                  text: "رفض",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
    );
  }
}
