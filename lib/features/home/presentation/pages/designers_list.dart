import 'package:designers_platform/core/utils/app_image.dart';
import 'package:designers_platform/core/widget/custom_text.dart';
import 'package:designers_platform/features/home/presentation/getx/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/screens/profile_screen.dart';

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
                        itemCount:
                            c.isLoading.value ? 6 : c.designerList.length,
                        padding: const EdgeInsets.all(12),
                        itemBuilder: (context, i) {
                          // في حالة التحميل نعرض عناصر وهمية
                          final designer =
                              c.isLoading.value ? null : c.designerList[i];

                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              leading: CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.grey.shade300,
                                backgroundImage: !c.isLoading.value &&
                                        designer?.avatarUrl != ''
                                    ? NetworkImage(designer!.avatarUrl!)
                                    : AssetImage(AppImage.icon1),
                              ),
                              title: Text(
                                designer?.name ?? 'Loading Name...',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                designer?.email ?? 'loading@email.com',
                              ),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_rounded),
                              onTap: !c.isLoading.value
                                  ? () => Get.to(() => ProfileScreen(
                                        currentDesigner: designer!,
                                      ))
                                  : null,
                            ),
                          );
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
