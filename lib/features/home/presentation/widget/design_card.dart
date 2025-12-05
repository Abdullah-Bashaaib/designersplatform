import 'package:cached_network_image/cached_network_image.dart';
import 'package:designers_platform/core/utils/app_image.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/screens/profile_screen.dart';
import 'package:designers_platform/features/home/presentation/getx/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignCard extends StatelessWidget {
  final Designer? designer;
  DesignCard({super.key, this.designer});
  final c = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey.shade300,
          backgroundImage: !c.isLoading.value && designer?.avatarUrl != ''
              ? CachedNetworkImageProvider(designer!.avatarUrl!)
              : AssetImage(AppImage.icon1),
        ),
        title: Text(
          designer?.name ?? 'Loading Name...',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          designer?.email ?? 'loading@email.com',
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: !c.isLoading.value
            ? () => Get.to(() => ProfileScreen(
                  currentDesigner: designer!,
                ))
            : null,
      ),
    );
  }
}
