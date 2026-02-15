import 'package:designers_platform/core/widget/custom_text.dart';
import 'package:designers_platform/features/home/presentation/getx/home_controller.dart';
import 'package:designers_platform/features/home/presentation/widget/design_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DesignersList extends StatelessWidget {
  const DesignersList({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    if (c.designerList.isEmpty) {
      c.getDesigners();
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CustomText(
              text: 'المصممين',
              style: TextStyleEnum.headingMedium,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                // Obx(()=>
                SearchBar(
              leading: Icon(Icons.search),
              hintText: 'ابحث عن مصمم...',
              onChanged: (value) {},
            ),
            // ),
          ),
          Expanded(
            child: Obx(
              () => c.designerList.isEmpty
                  ? Center(
                      child: CustomText(
                      text: 'لا يوجد مصممين',
                      style: TextStyleEnum.bodyLarge,
                    ))
                  : Skeletonizer(
                      enabled: c.isLoading.value,
                      child: ListView.builder(
                        controller: c.scrollController,
                        itemCount: c.isLoading.value
                            ? 6
                            : c.designerList.length +
                                (c.isMoreLoading.value ? 1 : 0),
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (context, i) {
                          if (c.isLoading.value) {
                            return DesignCard(designer: null);
                          }
                          if (i < c.designerList.length) {
                            return DesignCard(
                                designer: c.designerList.elementAt(i));
                          } else {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
