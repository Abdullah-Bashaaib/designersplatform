import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/routes/app_routes.dart';
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

class BuildInitialView extends StatelessWidget {
  final OrderEntity order;
  const BuildInitialView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<OrderGetx>();

    return CurrentUser.currentUser!.role != 'مصمم'
        ? const SizedBox(
            child: Center(
              child: Text('الرجاء الانتظار حتى يقبل المصمم طلبك'),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCard(
                  order: order.designType,
                  orderDescription: order.description == ''
                      ? 'لا يوجد وصف'
                      : order.description!,
                ),
                const Gap(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // زر الرفض
                    Expanded(
                      child: CustomOutlineButton(
                          onPressed: () {
                            c.deleteOrder(order.id);
                          },
                          text: "رفض"),
                    ),
                    Gap(
                      width: 5.w,
                    ),
                    Expanded(
                      child: Obx(
                        () => c.isLoadingEdit.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : CustomButton(
                                onPressed: () async {
                                  await c.updateOrder({
                                    'id': order.id,
                                    'status': 'مقبول',
                                  });

                                  order.status = 'مقبول';
                                  Get.offNamed(
                                    AppRoutes.chat,
                                    arguments: order,
                                  );
                                },
                                text: "قبول",
                              ),
                      ),
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
