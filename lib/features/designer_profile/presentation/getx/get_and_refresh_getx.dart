import 'package:designers_platform/features/designer_profile/domain/usecases/designer_usecase/get_profile_usecase.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/review_usecase/get_review_use_case.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/work_usecase/get_work_use_case.dart';
import 'package:get/get.dart';

import '../../../../core/utils/custom_dialog_getx.dart';

class GetOrRefreshDataGetX extends GetxController {
  final GetProfileUseCase getProfileUseCase;
  final GetReviewUseCase getReviewUseCase;
  final GetWorkUseCase getWorkUseCase;
  var isLoading = false.obs;

  GetOrRefreshDataGetX(
      {required this.getProfileUseCase,
      required this.getReviewUseCase,
      required this.getWorkUseCase});

  /// get the designer profile
  Future<void> getDataDesignerProfile(String designerId) async {
    isLoading.value = true;

    final designerProfile = await getProfileUseCase(designerId);
    designerProfile.fold((failure) {
      DialogHelper.showErrorSnackBar(
          title: "خطأ في جلب البيانات", message: failure.message);
    }, (designerProfile) => designerProfile); // handle success or failure

    isLoading.value = false;
  }

  /// get all reviews for designer
  Future<void> getDataReviews(String designerId) async {
    isLoading.value = true;

    final resultReview = await getReviewUseCase(designerId);
    resultReview.fold((failure) {
      DialogHelper.showErrorSnackBar(
          title: "خطأ في جلب البيانات", message: failure.message);
    }, (reviews) => reviews); // handle success or failure

    isLoading.value = false;
  }

  /// get all works of designer
  Future<void> getDataWorks(String designerId) async {
    isLoading.value = true;

    final resultWork = await getWorkUseCase(designerId);
    resultWork.fold((failure) {
      DialogHelper.showErrorSnackBar(
          title: "خطأ في جلب البيانات", message: failure.message);
    }, (works) => works); // handle success or failure

    isLoading.value = false;
  }
}
