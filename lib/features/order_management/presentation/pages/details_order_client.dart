import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/order_management/presentation/getx/order_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsOrderClient extends StatelessWidget {
  final OrderEntity order;

  const DetailsOrderClient({super.key, required this.order});

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

  List<Widget> _buildStars(int? rate) {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الطلب'),
        actions: [
          Obx(
            () => c.isLoading.value
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
                : IconButton(
                    tooltip: 'حذف الطلب',
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      await c.deleteOrder(order.id);
                    },
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if ((order.imageUrl ?? '').isNotEmpty)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  order.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(Icons.broken_image_outlined,
                            size: 48, color: Colors.grey),
                      ),
                    );
                  },
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
                  Text(
                    order.designName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        avatar: const Icon(Icons.category, size: 18),
                        label: Text(order.designType),
                      ),
                      Chip(
                        avatar: Icon(Icons.flag_circle,
                            size: 18, color: statusColor),
                        label: Text(order.status),
                        backgroundColor: statusColor.withOpacity(0.12),
                        labelStyle: TextStyle(color: statusColor),
                        side: BorderSide(color: statusColor.withOpacity(0.4)),
                      ),
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
            _infoTile(
              icon: Icons.brush,
              title: 'الاي دي',
              value: order.designerId,
            ),
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
                          children: const [
                            Icon(Icons.notes, size: 20),
                            SizedBox(width: 8),
                            Text('الوصف',
                                style: TextStyle(fontWeight: FontWeight.w700)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(order.description!.trim()),
                      ],
                    ),
                  ),
                ),
              ),

            // التقييم والتعليق
            if (order.rate != null || (order.feedback ?? '').trim().isNotEmpty)
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
                        Row(
                          children: [
                            ..._buildStars(order.rate),
                            const SizedBox(width: 8),
                            Text(order.rate?.toString() ?? 'غير مُقيّم'),
                          ],
                        ),
                        if ((order.feedback ?? '').trim().isNotEmpty) ...[
                          const SizedBox(height: 12),
                          const Text('ملاحظات:',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          Text(order.feedback!.trim()),
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
