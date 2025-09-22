import 'package:designers_platform/features/designer_profile/domain/usecases/designer_usecase/get_profile_usecase.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/review_usecase/get_review_use_case.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/work_usecase/get_work_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/utils/custom_dialog_getx.dart';
import '../../domain/entities/designer.dart';
import '../../domain/entities/review.dart';
import '../../domain/entities/work.dart';

class GetDataControllerGetx extends GetxController {
  // Designer UseCase
  final GetProfileUseCase getProfileUseCase;

  // Review UseCase
  final GetReviewUseCase getReviewUseCase;

  // Work UseCase
  final GetWorkUseCase getWorkUseCase;

  var isLoading = false.obs;
  var designer = Rxn<Designer>();
  var reviews = <Review>[].obs; // قائمة التقييمات
  var works = <Work>[].obs;

  GetDataControllerGetx(
    this.getProfileUseCase,
    this.getReviewUseCase,
    this.getWorkUseCase,
  );
  @override
  void onInit() {
    super.onInit();
    getDataDesignerProfile("321");
    getDataReviews('321');
    getDataWorks('321');
  }

  /// get the designer profile
  Future<void> getDataDesignerProfile(String designerId) async {
    isLoading.value = true;

    final result = await getProfileUseCase(designerId);

    result.fold(
      (failure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          DialogHelper.showErrorSnackBar(
              title: "خطأ في جلب البيانات", message: failure.message);
        });
      },
      (profile) {
        designer.value = profile;
        debugPrint("hi am here ${designer.value?.user.id}");
      },
    );

    isLoading.value = false;
  }

  /// get all reviews for designer
  Future<void> getDataReviews(String designerId) async {
    isLoading.value = true;

    final result = await getReviewUseCase(designerId);
    result.fold(
      (failure) {
        DialogHelper.showErrorSnackBar(
            title: "خطأ في جلب التقييمات", message: failure.message);
      },
      (data) {
        reviews.assignAll(data);
      },
    );

    isLoading.value = false;
  }

  /// get all works of designer
  Future<void> getDataWorks(String designerId) async {
    isLoading.value = true;

    final result = await getWorkUseCase(designerId);
    result.fold(
      (failure) {
        DialogHelper.showErrorSnackBar(
            title: "خطأ في جلب الأعمال", message: failure.message);
      },
      (data) {
        works.assignAll(data);
      },
    );

    isLoading.value = false;
  }
}
