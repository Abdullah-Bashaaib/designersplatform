import 'package:designers_platform/features/supervisor/presentation/getx/supervisor_controller.dart';
import 'package:designers_platform/features/order_management/presentation/widgets/build_card_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingOrdersPage extends StatelessWidget {
  const PendingOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is found
    // It's expected that SupervisorController is injected/put before navigating here or via binding
    final controller = Get.find<SupervisorController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('الطلبات المعلقة'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.pendingOrders.isEmpty) {
          return const Center(child: Text('لا توجد طلبات معلقة'));
        }

        return ListView.builder(
          itemCount: controller.pendingOrders.length,
          itemBuilder: (context, index) {
            final order = controller.pendingOrders[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // Resuing existing order card logic or building a custom simplified one
                    // We need to show basic info + Approve Button
                    ListTile(
                      title: Text(order.designType),
                      subtitle: Text(
                          'العميل: ${order.clientName}\nالحالة: ${order.status}'),
                      trailing: Text('${order.price ?? 0} ريال'),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            controller.approveOrder(order.id);
                          },
                          icon: const Icon(Icons.check_circle),
                          label: const Text('قبول الطلب'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        // Add View Details button if needed, assuming navigation to existing details page
                        // TextButton(onPressed: (){}, child: Text("تفاصيل"))
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
