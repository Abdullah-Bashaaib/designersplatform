import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/widget/build_text_field.dart';
import 'package:designers_platform/core/widget/custom_text.dart';
import 'package:designers_platform/features/home/presentation/getx/home_controller.dart';
import 'package:designers_platform/features/home/presentation/pages/designers_list.dart';
import 'package:designers_platform/features/home/presentation/widget/building_designer_list.dart';
import 'package:designers_platform/features/order_management/presentation/pages/view_order_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widget/build_quick_card.dart';

class ClientHomePage extends StatelessWidget {
  const ClientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('منصة المصممين'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🧑‍💻 الترحيب بالعميل
            CustomText(
              text: 'مرحبًا بك 👋',
            ),
            SizedBox(height: 6.h),
            CustomText(
              text: 'ابحث عن مصممك المثالي أو تابع طلباتك الحالية',
            ),
            SizedBox(height: 20.h),

            /// 🔍 شريط البحث
            BuildTextField(
              hintText: 'ابحث عن مصمم أو نوع تصميم...',
              // suffixIcon: Icon(Icons.search),
              prefixIcon: Icons.search,
            ),
            // TextField(
            //     decoration: AppStyles.getInputDecoration(
            //   hintText: 'ابحث عن مصمم أو نوع تصميم...',
            //   prefixIcon: const Icon(Icons.search),
            // )
            // ),
            SizedBox(height: 24.h),

            /// 🧩 البطاقات السريعة
            CustomText(
              text: 'خدمات سريعة',
            ),
            SizedBox(height: 12.h),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                BuildQuickCard(
                  icon: Icons.design_services,
                  title: 'تصفح المصممين',
                  onTap: () {
                    Get.to(() => DesignersList());
                  },
                ),
                BuildQuickCard(
                  icon: Icons.shopping_bag_outlined,
                  title: 'طلباتي',
                  onTap: () {
                    Get.to(() => ViewClientOrders());
                  },
                ),
                BuildQuickCard(
                  icon: Icons.local_offer_outlined,
                  title: 'العروض',
                  onTap: () {},
                ),
                BuildQuickCard(
                  icon: Icons.favorite_border,
                  title: 'المفضلة',
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(height: 30.h),

            /// 🧑‍🎨 أفضل المصممين
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'أفضل المصممين',
                  style: AppStyles.bodyLarge.copyWith(
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => DesignersList());
                  },
                  child: const Text('عرض الكل'),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Obx(
              () => c.designerList.isNotEmpty
                  ? BuildingDesignerList()
                  : Center(
                      child: Text('لا يوجد مصممين'),
                    ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNav(context),
    );
  }
}
