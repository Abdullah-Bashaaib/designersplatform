import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/widgets/bio_custom.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/widgets/buttons_reaction.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/widgets/grid_works_custom.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/widgets/profile_image_and_statistic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../getx/getData_controller_getx.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final usernameController = TextEditingController();
  final controller = Get.find<GetDataControllerGetx>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Obx(() => Text(
              controller.designer.value!.name,
              style: AppStyles.headingMedium,
            )),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    FaIcon(
                      Icons.no_accounts,
                      color: Colors.redAccent,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "حذف الحساب",
                      style: TextStyle(color: Colors.redAccent),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileImageAndStatistic(),
                    BioCustom(),
                    ButtonsReaction(),
                    GridWorksCustom(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
