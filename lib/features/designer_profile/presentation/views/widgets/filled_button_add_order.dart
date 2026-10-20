import 'package:designers_platform/core/utils/app_styles.dart';
import 'package:designers_platform/core/widget/order_dialog.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/designer_profile/presentation/getx/getData_controller_getx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FilledButtonAddOrder extends StatefulWidget {
  final Designer? currentDesigner;

  const FilledButtonAddOrder({super.key, this.currentDesigner});

  @override
  State<FilledButtonAddOrder> createState() => _FilledButtonAddOrderState();
}

class _FilledButtonAddOrderState extends State<FilledButtonAddOrder> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _type = TextEditingController();

  final TextEditingController _description = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _type.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<GetDataControllerGetx>();

    return FilledButton(
      style: AppStyles.secondaryButtonStyle,
      onPressed: () {
        OrderDialog.show(
            title: 'طلب خدمه',
            onConfirm: (type, description) async {
              await c.addOrder(widget.currentDesigner!, type, description);
            },
            currentDesigner: widget.currentDesigner);
      },
      child: Text(
        "طلب خدمة",
        style: TextStyle(fontSize: 15.sp),
      ),
    );
  }
}
