import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/work.dart';
import 'package:designers_platform/features/designer_profile/presentation/getx/add_update_delete_getx.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TempAddData extends StatelessWidget {
  TempAddData({super.key});
  final controller = Get.find<AddUpdateDeleteGetx>();
  final sharedPref = Get.find<SharedPreferences>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              FilledButton(
                onPressed: () async {
                  final worksList = List.generate(3000, (index) {
                    return Work(
                        id: '301',
                        designerId: '101',
                        imageUrl: '',
                        description: '',
                        createdAt: DateTime.now(),
                        likesCount: 5);
                  });
                  final user = User(
                      id: "101",
                      name: "Ali",
                      email: "ali@gmail.com",
                      password: "123",
                      role: "designer");
                  final designer = Designer(
                      user: user,
                      reviewId: "201",
                      bio: "none",
                      numberBank: 774551448,
                      nameBank: "Bank name",
                      specialization: "UI/UX",
                      isAvailable: 1,
                      totalOrders: 2500,
                      worksCount: 3000,
                      workList: worksList);
                  await controller.updateDesigner(designer);
                  print("Added Done");
                  Get.to(() => ProfileScreen());
                },
                child: Text("Submit"),
              ),
              FilledButton(
                  onPressed: () {
                    sharedPref.clear();
                    print("Clear Done");
                  },
                  child: Text("Clear"))
            ],
          ),
        ),
      ),
    );
  }
}
