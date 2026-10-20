import 'package:designers_platform/features/home/presentation/getx/home_controller.dart';
import 'package:designers_platform/features/home/presentation/widget/designer_bottom_nav.dart';
import 'package:designers_platform/features/home/presentation/widget/designer_fab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignerHome extends StatelessWidget {
  const DesignerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    return Obx(
      () => Scaffold(
        body: c.pages[c.currentIndex.value],
        floatingActionButton:
            c.currentIndex.value == 0 ? DesignerFAB() : SizedBox(),
        bottomNavigationBar: DesignerBottomNav(),
      ),
    );
  }
}
