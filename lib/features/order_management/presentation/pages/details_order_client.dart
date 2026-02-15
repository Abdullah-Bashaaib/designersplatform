import 'package:cached_network_image/cached_network_image.dart';
import 'package:designers_platform/core/utils/app_colors.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/core/widget/custom_button.dart';
import 'package:designers_platform/core/widget/order_dialog.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/order_management/presentation/getx/order_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_routes.dart';

class DetailsOrderClient extends StatelessWidget {
  final OrderEntity order;
  // final double rate;
  // final String feedback;

  const DetailsOrderClient({
    super.key,
    required this.order,
  });

  String _formatDate(DateTime dt) {
    final d = dt.toLocal();
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    final hh = d.hour.toString().padLeft(2, '0');
    final mm = d.minute.toString().padLeft(2, '0');
    return '$y-$m-$day  $hh:$mm';
  }

  String _formatPrice(double? price) {
    if (price == null) return 'غير محدد';
    return price.toStringAsFixed(2);
  }

  Color _statusColor(BuildContext context, String status) {
    final s = status.toLowerCase().trim();
    switch (s) {
      case 'pending':
      case 'قيد الانتظار':
        return Colors.amber;
      case 'in_progress':
      case 'قيد التنفيذ':
        return Colors.blue;
      case 'completed':
      case 'مكتمل':
        return Colors.green;
      case 'canceled':
      case 'ملغي':
        return Colors.red;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  List<Widget> _buildStars(double? rate) {
    final r = (rate ?? 0).clamp(0, 5);
    return List.generate(
      5,
      (i) => Icon(
        i < r ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: 20,
      ),
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(value, style: TextStyle(color: valueColor)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      horizontalTitleGap: 12,
      dense: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<OrderGetx>();
    final statusColor = _statusColor(context, order.status);
    final Rx<OrderEntity> currentOrder = order.obs;
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الطلب'),
        actions: [
          Row(
            children: [
              order.status == 'قيد الانتظار'
                  ? Obx(
                      () => c.isLoadingEdit.value
                          ? Padding(
                              padding: const EdgeInsets.all(10),
                              child: CircularProgressIndicator(),
                            )
                          : IconButton(
                              onPressed: () {
                                OrderDialog.show(
                                    title: 'تعديل الطلب',
                                    initialType: order.designType,
                                    initialDescription: order.description,
                                    onConfirm: (type, description) {
                                      final fields = {
                                        'id': order.id,
                                        'designType': type,
                                        'description': description
                                      };
                                      c.updateOrder(fields);
                                      currentOrder.update((val) {
                                        val?.designType = type;
                                        val?.description = description;
                                      });
                                    });
                              },
                              icon: Icon(
                                Icons.edit,
                                color: const Color.fromARGB(255, 255, 193, 59),
                              ),
                            ),
                    )
                  : SizedBox(),
              SizedBox(
                width: 5,
              ),
              Obx(
                () => c.isLoading.value
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircularProgressIndicator(),
                      )
                    : order.status == 'قيد الانتظار'
                        ? IconButton(
                            tooltip: 'حذف الطلب',
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              await c.deleteOrder(order.id);
                            },
                          )
                        : SizedBox(),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if ((order.imageUrl ?? '').isNotEmpty)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: order.imageUrl!,
                  fit: BoxFit.cover,
                  // أثناء التحميل
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  // إذا حدث خطأ
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                        size: 48,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              )
            else
              Container(
                height: 180,
                color: Colors.grey.shade100,
                child: const Center(
                  child: Icon(Icons.image_not_supported_outlined,
                      size: 48, color: Colors.grey),
                ),
              ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   order.designerName,
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .titleLarge
                  //       ?.copyWith(fontWeight: FontWeight.bold),
                  // ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Obx(
                        () => Chip(
                          avatar: const Icon(Icons.category, size: 18),
                          label: Text(currentOrder.value.designType),
                        ),
                      ),
                      Chip(
                        avatar: Icon(Icons.flag_circle,
                            size: 18, color: statusColor),
                        label: Text(order.status),
                        backgroundColor: statusColor.withValues(alpha: 0.12),
                        labelStyle: TextStyle(color: statusColor),
                        side: BorderSide(color: statusColor.withValues(alpha: 0.4)),
                      ),
                      if (order.status == 'مكتمل' &&
                          order.adminApproval == 'true')
                        IconButton(
                          onPressed: () {
                            c.saveDesign(order.imageUrl!);
                          },
                          icon: Icon(Icons.download),
                          color: AppColors.primaryColor,
                        )
                      else if (order.status == 'مقبول')
                        IconButton(
                          onPressed: () => Get.toNamed(
                            AppRoutes.chat,
                            arguments: order,
                          ),
                          icon: Icon(Icons.chat),
                          color: AppColors.primaryColor,
                        )
                      else if (order.status == 'مكتمل' &&
                          order.adminApproval != 'true')
                        c.isLoadingSend.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : IconButton(
                                onPressed: () {
                                  c.sendPaymentViaWhatsApp(
                                      order.id, order.designType);
                                },
                                icon: Icon(Icons.payment),
                                color: AppColors.primaryColor,
                                tooltip: 'إرسال سند الدفع عبر واتساب',
                              )
                      else
                        SizedBox(),

                      // ActionChip(
                      //   avatar: const Icon(Icons.tag, size: 18),
                      //   label: Text('ID: ${order.id}'),
                      //   onPressed: () async {
                      //     await Clipboard.setData(
                      //         ClipboardData(text: order.id));
                      //     if (context.mounted) {
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         const SnackBar(content: Text('تم نسخ رقم الطلب')),
                      //       );
                      //     }
                      //   },
                      // ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(height: 24),

            _infoTile(
              icon: Icons.person,
              title: 'العميل',
              value: order.clientName,
            ),
            _infoTile(
              icon: Icons.brush,
              title: 'المصمم',
              value: order.designerName,
            ),
            // _infoTile(
            //   icon: Icons.brush,
            //   title: 'الاي دي',
            //   value: order.designerId,
            // ),
            _infoTile(
              icon: Icons.monetization_on,
              title: 'السعر',
              value: _formatPrice(order.price),
            ),
            _infoTile(
              icon: Icons.event,
              title: 'تاريخ الإنشاء',
              value: _formatDate(order.createAt),
            ),

            // الوصف
            if ((order.description ?? '').trim().isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.notes, size: 20),
                            SizedBox(width: 8.w),
                            Text('الوصف',
                                style: TextStyle(fontWeight: FontWeight.w700)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Obx(() => Text(currentOrder.value.description!.trim())),
                      ],
                    ),
                  ),
                ),
              ),

            // التقييم والتعليق

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.reviews, size: 20),
                          SizedBox(width: 8),
                          Text('التقييم',
                              style: TextStyle(fontWeight: FontWeight.w700)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ..._buildStars(c.getRate(order.id) ?? 0.0),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Text(
                                    c.getRate(order.id).toString())),
                            // SizedBox(
                            //   width: 90.w,
                            // ),
                            c.getRate(order.id) == 0.0 &&
                                    order.status == 'مكتمل'
                                ? Expanded(
                                    child: Obx(
                                      () => c.isLoadingFeedback.value
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : CustomButton(
                                              onPressed: () {
                                                DialogHelper.showRatingDialog(
                                                    orderId: order.id,
                                                    designerId:
                                                        order.designerId,
                                                    title:
                                                        'كيف ترى عمل المصمم');
                                                // print(order.designerId);
                                              },
                                              text: 'تقييم'),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      if ((c.getFeedback(order.id) ?? '')
                          .trim()
                          .isNotEmpty) ...[
                        const SizedBox(height: 12),
                        const Text('ملاحظات:',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Text(c.getFeedback(order.id) ?? ''),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
