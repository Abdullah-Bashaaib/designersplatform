import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/widgets/bio_custom.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/widgets/buttons_reaction.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/widgets/profile_image_and_statistic.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "username",
          style: AppStyles.headingLarge,
        ),
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileImageAndStatistic(),
                  BioCustom(),
                  ButtonsReaction(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
