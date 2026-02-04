import 'package:designers_platform/features/order_management/presentation/getx/order_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/widget/custom_button.dart';
import '../../../../core/widget/custom_card.dart';
import '../../../../core/widget/custom_outline_button.dart';
import '../../../../core/widget/custom_text.dart';
import '../../../../core/widget/gap.dart';
import '../../domain/entity/orders.dart';
import '../getx/chat_getx.dart';

// Widget buildInitialView(ChatOrderGetX controller, BuildContext context,
//     OrderEntity order, OrderGetx c) {
//   return Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         CustomCard(
//           order: order.designType,
//           orderDescription:
//               order.description == '' ? 'لا يوجد وصف' : order.description!,
//         ),
//         const Gap(height: 30),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             // زر الرفض
//             Expanded(
//               child: CustomOutlineButton(
//                   onPressed: () {
//                     controller.rejectOrder();
//                     c.deleteOrder(order.id);
//                   },
//                   text: "رفض"),
//             ),
//             Gap(
//               width: 5.w,
//             ),
//             Expanded(
//               child: CustomButton(
//                   onPressed: controller.acceptOrder(id: order.id),
//                   text: "قبول"),
//             )
//           ],
//         ),
//         const Gap(height: 20),
//         const CustomText(
//           text: "عند قبول الطلب، ستتمكن من بدء المحادثة.",
//           color: Colors.grey,
//         ),
//       ],
//     ),
//   );
// }

class BuildInitialView extends StatelessWidget {
  final OrderEntity order;
  const BuildInitialView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<OrderGetx>();
    final controller = Get.find<ChatOrderGetX>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCard(
            order: order.designType,
            orderDescription:
                order.description == '' ? 'لا يوجد وصف' : order.description!,
          ),
          const Gap(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // زر الرفض
              Expanded(
                child: CustomOutlineButton(
                    onPressed: () {
                      controller.rejectOrder();
                      c.deleteOrder(order.id);
                    },
                    text: "رفض"),
              ),
              Gap(
                width: 5.w,
              ),
              Expanded(
                child: controller.acceptedLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomButton(
                        onPressed: () => controller.acceptOrder(id: order.id),
                        text: "قبول"),
              )
            ],
          ),
          const Gap(height: 20),
          const CustomText(
            text: "عند قبول الطلب، ستتمكن من بدء المحادثة.",
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
