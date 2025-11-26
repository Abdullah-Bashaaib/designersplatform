import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/features/designer_profile/domain/entities/designer.dart';
import 'package:designers_platform/features/home/domain/usecases/get_designers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GetDesignersUsecase getDesignersUsecase;

  HomeController(this.getDesignersUsecase);

  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  var designerList = <Designer>[].obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    getDesigners();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreDesigners();
      }
    });
    super.onInit();
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
