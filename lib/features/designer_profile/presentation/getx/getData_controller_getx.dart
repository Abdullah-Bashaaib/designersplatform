import 'package:designers_platform/core/utils/key_app.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/review_usecase/get_review_use_case.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/work_usecase/get_work_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/usecase/logout.dart';
import '../../../../core/utils/custom_dialog_getx.dart';
import '../../../../core/utils/messages.dart';
import '../../../auth/presentation/pages/welcome_page.dart';
import '../../domain/entities/designer.dart';
import '../../domain/entities/review.dart';
import '../../domain/entities/work.dart';
import '../../domain/usecases/designer_usecase/get_profile_usecase.dart';

class GetDataControllerGetx extends GetxController {
  final GetProfileUseCase getProfileUseCase;
  final GetReviewUseCase getReviewUseCase;
  final GetWorkUseCase getWorkUseCase;
  final LogoutUsecase logoutUsecase;
  final SharedPreferences sharedPreferences;

  var isLoading = false.obs;
  var designer = Rxn<Designer>();
  var reviews = <Review>[].obs;
  var works = <Work>[].obs;

  GetDataControllerGetx(
    this.getProfileUseCase,
    this.getReviewUseCase,
    this.getWorkUseCase,
    this.logoutUsecase,
    this.sharedPreferences,
  );

  @override
  void onInit() {
    super.onInit();
    getDataDesignerProfile();
    getDataReviews();
    getDataWorks();
  }

  /// get the designer profile
  Future<void> getDataDesignerProfile() async {
    isLoading.value = true;

    final id = sharedPreferences.getString(KeySharedPref.kUserId);

    if (id == null) {
      Get.offAll(() => WelcomePage());
      DialogHelper.showErrorSnackBar(
        title: "خطأ",
        message: "لم يتم العثور على معرف المستخدم",
      );
      isLoading.value = false;
      return;
    }

    final result = await getProfileUseCase(id);

    result.fold(
      (failure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          DialogHelper.showErrorSnackBar(
            title: "خطأ في جلب البيانات",
            message: failure.message,
          );
        });
        Get.offAll(() => WelcomePage());
      },
      (user) {
        designer.value = user;
      },
    );

    isLoading.value = false;
  }

  /// get all reviews for designer
  Future<void> getDataReviews() async {
    isLoading.value = true;

    final id = sharedPreferences.getString(KeySharedPref.kUserId);
    if (id == null) {
      isLoading.value = false;
      return;
    }

    final result = await getReviewUseCase(id);

    result.fold(
      (failure) {
        DialogHelper.showErrorSnackBar(
          title: "خطأ في جلب التقييمات",
          message: failure.message,
        );
      },
      (data) {
        reviews.assignAll(data);
      },
    );

    isLoading.value = false;
  }

  /// get all works of designer
  Future<void> getDataWorks() async {
    isLoading.value = true;

    final id = sharedPreferences.getString(KeySharedPref.kUserId);
    if (id == null) {
      isLoading.value = false;
      return;
    }

    final result = await getWorkUseCase(id);

    result.fold(
      (failure) {
        DialogHelper.showErrorSnackBar(
          title: "خطأ في جلب الأعمال",
          message: failure.message,
        );
      },
      (data) {
        works.assignAll(data);
      },
    );

    isLoading.value = false;
  }

  void logout() {
    logoutUsecase.call();
    Get.offAll(() => WelcomePage());
    DialogHelper.showSuccessSnackBar(title: 'تم', message: logoutMessage);
  }
}
