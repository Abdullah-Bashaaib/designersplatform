import 'package:designers_platform/features/home/presentation/getx/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignerBottomNav extends StatelessWidget {
  const DesignerBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();

    return BottomNavigationBar(
      currentIndex: c.currentIndex.value,
      onTap: c.changeTab,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: 'الطلبات',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'الملف الشخصي',
        ),
      ],
    );
  }
}
