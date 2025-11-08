import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/widget/build_text_field.dart';
import 'package:designers_platform/core/widget/custom_text.dart';
import 'package:designers_platform/features/home/presentation/getx/home_controller.dart';
import 'package:designers_platform/features/home/presentation/pages/designers_list.dart';
import 'package:designers_platform/features/order_management/presentation/pages/view_order_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
                _buildQuickCard(
                  context,
                  icon: Icons.design_services,
                  title: 'تصفح المصممين',
                  onTap: () {
                    Get.to(() => DesignersList());
                  },
                ),
                _buildQuickCard(
                  context,
                  icon: Icons.shopping_bag_outlined,
                  title: 'طلباتي',
                  onTap: () {
                    Get.to(() => ViewClientOrders());
                  },
                ),
                _buildQuickCard(
                  context,
                  icon: Icons.local_offer_outlined,
                  title: 'العروض',
                  onTap: () {},
                ),
                _buildQuickCard(
                  context,
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
                    Get.toNamed('/designers');
                  },
                  child: const Text('عرض الكل'),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            _buildDesignerList(context),
            SizedBox(height: 30.h),

            /// 📦 آخر الطلبات
            Text(
              'آخر طلباتك',
              style: AppStyles.bodyLarge.copyWith(
                color:
                    isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            _buildRecentOrders(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  /// 🔹 بطاقة سريعة
  Widget _buildQuickCard(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCardColor : AppColors.cardColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
              blurRadius: 8.r,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 32.sp,
                color:
                    isDark ? AppColors.secondaryColor : AppColors.primaryColor),
            SizedBox(height: 10.h),
            Text(
              title,
              style: AppStyles.bodyMedium.copyWith(
                color:
                    isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🧑‍🎨 قائمة المصممين المميزين
  Widget _buildDesignerList(BuildContext context) {
    final designers = List.generate(5, (i) {
      return {
        "name": "المصمم ${i + 1}",
        "rating": 4.5 - (i * 0.3),
        "image":
            "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg",
      };
    });

    return SizedBox(
      height: 150.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: designers.length,
        separatorBuilder: (_, __) => SizedBox(width: 12.w),
        itemBuilder: (context, i) {
          final d = designers[i];
          final isDark = Theme.of(context).brightness == Brightness.dark;
          return Container(
            width: 120.w,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCardColor : AppColors.cardColor,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: AppStyles.cardShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.r)),
                  child: Image.network(
                    d["image"]!.toString(),
                    height: 80.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  d["name"]!.toString(),
                  style: AppStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(
                      "${d["rating"]}",
                      style: AppStyles.caption.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 📦 آخر الطلبات
  Widget _buildRecentOrders(BuildContext context) {
    final orders = List.generate(3, (i) {
      return {
        "name": "تصميم شعار ${i + 1}",
        "status": "قيد التنفيذ",
        "image":
            "https://images.pexels.com/photos/3184292/pexels-photo-3184292.jpeg",
      };
    });

    return Column(
      children: orders.map((o) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          color: isDark ? AppColors.darkCardColor : AppColors.cardColor,
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                o["image"]!,
                width: 60.w,
                height: 60.h,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(o["name"]!,
                style: AppStyles.bodyMedium.copyWith(
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.textPrimary)),
            subtitle: Text(o["status"]!,
                style: AppStyles.bodySmall.copyWith(color: Colors.amber)),
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                size: 18.sp, color: AppColors.textSecondary),
          ),
        );
      }).toList(),
    );
  }

  /// 🚀 شريط التنقل السفلي
  Widget _buildBottomNav(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor:
          isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'المصممون'),
        BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline), label: 'المحادثات'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag), label: 'طلباتي'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
      ],
      currentIndex: 0,
      onTap: (index) {
        // يمكنك التنقل عبر GetX أو Get.offAllNamed(...)
      },
    );
  }
}
