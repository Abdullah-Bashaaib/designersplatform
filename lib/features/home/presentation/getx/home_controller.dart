import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/designer_usecase/get_profile_usecase.dart';
import 'package:designers_platform/features/designer_profile/presentation/views/screens/profile_screen.dart';
import 'package:designers_platform/features/home/domain/usecases/get_activate_order_usecase.dart';
import 'package:designers_platform/features/home/domain/usecases/get_designers.dart';
import 'package:designers_platform/features/home/presentation/pages/designer_home.dart';
import 'package:designers_platform/features/home/presentation/widget/build_designer_home.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/order_management/presentation/pages/view_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GetDesignersUsecase getDesignersUsecase;
  final GetProfileUseCase getProfileUseCase;
  final GetActivateOrderUsecase getActivateOrderUsecase;

  HomeController(this.getDesignersUsecase, this.getProfileUseCase,
      this.getActivateOrderUsecase);

  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  var designerList = <Designer>[].obs;
  ScrollController scrollController = ScrollController();
  var user = CurrentUser.currentUser.obs;
  var designer = Rxn<Designer>();
  var activateOrders = <OrderEntity>[].obs;

  var currentIndex = 0.obs;

  @override
  void onInit() {
    if (CurrentUser.currentUser!.role == 'عميل') {
      getDesigners();
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          getMoreDesigners();
        } else if (CurrentUser.currentUser!.role == 'مصمم') {
          getDesigner();
        }
      });
    }

    super.onInit();
  }

  final pages = [
    BuildDesignerHome(),
    ViewOrder(),
    ProfileScreen(),
  ];

  void changeTab(int index) {
    currentIndex.value = index;
  }

  Future<void> getActivateOrders() async {
    final result = await getActivateOrderUsecase();
    result.fold(
      (l) {
        DialogHelper.showErrorSnackBar(title: 'خطـــأ', message: l.message);
      },
      (r) {
        activateOrders.value = r;
      },
    );
  }

  Future<void> getDesigner() async {
    final result = await getProfileUseCase(CurrentUser.currentUser!.id);
    result.fold(
      (l) {
        DialogHelper.showErrorSnackBar(title: 'خطـــأ', message: l.message);
      },
      (r) {
        designer.value = r;
      },
    );
  }

  Future<void> getDesigners() async {
    isLoading.value = true;
    final result = await getDesignersUsecase.call(limit: 10);
    result.fold((f) {
      DialogHelper.showErrorSnackBar(title: 'خطـــأ', message: f.message);
    }, (r) {
      designerList.value = r;
    });
    isLoading.value = false;
  }

  Future<void> getMoreDesigners() async {
    if (isMoreLoading.value) return;
    isMoreLoading.value = true;
    final result = await getDesignersUsecase.call(
        limit: 10, startAfter: designerList.last);
    result.fold((f) {
      DialogHelper.showErrorSnackBar(title: 'خطـــأ', message: f.message);
    }, (r) {
      if (r.isNotEmpty) {
        designerList.addAll(r);
      }
    });
    isMoreLoading.value = false;
  }
}
