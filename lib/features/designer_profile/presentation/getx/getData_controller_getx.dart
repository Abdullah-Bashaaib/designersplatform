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
import '../../domain/usecases/designer_usecase/delete_profile_usecase.dart';
import '../../domain/usecases/designer_usecase/get_profile_usecase.dart';
import '../../domain/usecases/designer_usecase/update_profile_usecase.dart';
import '../../domain/usecases/review_usecase/add_review_use_case.dart';
import '../../domain/usecases/review_usecase/delete_review_use_case.dart';
import '../../domain/usecases/review_usecase/update_review_use_case.dart';
import '../../domain/usecases/work_usecase/add_work_use_case.dart';
import '../../domain/usecases/work_usecase/delete_work_use_case.dart';
import '../../domain/usecases/work_usecase/update_work_use_case.dart';

class GetDataControllerGetx extends GetxController {
  final GetProfileUseCase getProfileUseCase;
  final GetReviewUseCase getReviewUseCase;
  final GetWorkUseCase getWorkUseCase;
  final LogoutUsecase logoutUsecase;
  final SharedPreferences sharedPreferences;
  // Designer
  final UpdateProfileUseCase updateProfileUseCase;
  final DeleteProfileUseCase deleteProfileUseCase;
  // Review
  final AddReviewUseCase addReviewUseCase;
  final UpdateReviewUseCase updateReviewUseCase;
  final DeleteReviewUseCase deleteReviewUseCase;
  // Work
  final AddWorkUseCase addWorkUseCase;
  final UpdateWorkUseCase updateWorkUseCase;
  final DeleteWorkUseCase deleteWorkUseCase;

  var isLoading = false.obs;
  var designerR = Rxn<Designer>();
  var reviews = <Review>[].obs;
  var works = <Work>[].obs;

  GetDataControllerGetx(
    this.getProfileUseCase,
    this.getReviewUseCase,
    this.getWorkUseCase,
    this.logoutUsecase,
    this.sharedPreferences,
    this.addReviewUseCase,
    this.addWorkUseCase,
    this.deleteProfileUseCase,
    this.deleteReviewUseCase,
    this.deleteWorkUseCase,
    this.updateProfileUseCase,
    this.updateReviewUseCase,
    this.updateWorkUseCase,
  );

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDataDesignerProfile(); // ← الملاحة ستكون آمنة هنا
    });
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
        designerR.value = user;
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

  Future<void> updateDesigner(Designer designer) async {
    isLoading.value = true;

    final result = await updateProfileUseCase(designer);
    result.fold((failure) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DialogHelper.showErrorSnackBar(
            title: "Error", message: failure.message);
      });
    }, (profile) {
      getDataDesignerProfile();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DialogHelper.showSuccessSnackBar(
            title: "نجاح", message: "تمت التعديل بنجاح!");
      });
    });
    isLoading.value = false;
  }

  void logout() {
    logoutUsecase.call();
    Get.offAll(() => WelcomePage());
    DialogHelper.showSuccessSnackBar(title: 'تم', message: logoutMessage);
  }
}
