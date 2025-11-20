import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/order_management/presentation/getx/order_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_downloader/image_downloader.dart';

class ViewCompletedOrder extends StatelessWidget {
  final String? imageUrl;

  ViewCompletedOrder({super.key, this.imageUrl});
  final c = Get.find<OrderGetx>();
  @override
  Widget build(BuildContext context) {
    // final image = imageUrl; // رابط الصورة النهائية

    return Scaffold(
      appBar: AppBar(
        title: const Text("التصميم المكتمل"),
      ),
      body: Column(
        children: [
          // الصورة
          Expanded(
            child: Center(
              child: imageUrl == null || imageUrl!.isEmpty
                  ? const Text("لا توجد صورة متاحة")
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loading) {
                          if (loading == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
            ),
          ),

          // زر التحميل
          imageUrl!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      c.saveDesign(imageUrl!);
                    },
                    icon: const Icon(Icons.download),
                    label: const Text("تنزيل الصورة"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
