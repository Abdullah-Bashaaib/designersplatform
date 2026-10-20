import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../getx/search_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<SearchControl>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final suggestionTags = [
      'شعار',
      'هوية بصرية',
      'بوستر',
      'كرت عمل',
      'واجهة تطبيق',
      'تصميم متجر',
      'غلاف كتاب',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('البحث'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔍 حقل البحث
            Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'ابحث عن مصمم أو نوع تصميم...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            /// 💡 اقتراحات لأنواع التصاميم
            Text(
              'اقتراحات سريعة',
              style: AppStyles.bodyLarge,
            ),
            SizedBox(height: 10.h),

            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: suggestionTags.map((tag) {
                return GestureDetector(
                  onTap: () {},
                  child: Chip(
                    label: Text(tag),
                    backgroundColor:
                        isDark ? Colors.blueGrey.shade700 : Colors.blue.shade50,
                    labelStyle: TextStyle(
                      color: isDark ? Colors.white : Colors.blue.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 20.h),

            // /// 🧭 نوع البحث (مصممين / تصاميم)
            // Obx(() => Row(
            //       children: c.searchTypes.map((type) {
            //         final isSelected = c.searchType.value == type;
            //         return Padding(
            //           padding: EdgeInsets.only(right: 8.w),
            //           child: ChoiceChip(
            //             label: Text(type),
            //             selected: isSelected,
            //             onSelected: (_) => c.onTypeChanged(type),
            //             selectedColor: Colors.blue.shade100,
            //           ),
            //         );
            //       }).toList(),
            //     )),

            SizedBox(height: 20.h),

            /// 🧾 نتائج البحث
            Expanded(
              child: Obx(() {
                if (c.query.isEmpty) {
                  return Center(
                    child: Opacity(
                      opacity: 0.6,
                      child: Text(
                        'ابدأ الكتابة للبحث...',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  );
                }

                if (c.resultsDesigns.isEmpty) {
                  return const Center(child: Text('لا توجد نتائج مطابقة'));
                }

                return ListView.separated(
                    itemCount: c.resultsDesigns.length,
                    separatorBuilder: (_, __) =>
                        Divider(height: 16.h, thickness: 0.5),
                    itemBuilder: (context, i) {
                      final item = c.resultsDesigns[i];
                      return ListTile(
                        leading: const Icon(Icons.brush_outlined,
                            color: Colors.blue),
                        title: Text(item['title']),
                        subtitle: Text(item['category']),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            size: 16),
                        onTap: () {},
                      );
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
