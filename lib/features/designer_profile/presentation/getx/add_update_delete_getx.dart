import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/utils/custom_dialog_getx.dart';
import '../../domain/entities/designer.dart';
import '../../domain/entities/review.dart';
import '../../domain/usecases/designer_usecase/delete_profile_usecase.dart';
import '../../domain/usecases/designer_usecase/update_profile_usecase.dart';
import '../../domain/usecases/review_usecase/add_review_use_case.dart';
import '../../domain/usecases/review_usecase/delete_review_use_case.dart';
import '../../domain/usecases/review_usecase/update_review_use_case.dart';
import '../../domain/usecases/work_usecase/add_work_use_case.dart';
import '../../domain/usecases/work_usecase/delete_work_use_case.dart';
import '../../domain/usecases/work_usecase/update_work_use_case.dart';

class AddUpdateDeleteGetx extends GetxController {
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
  var designer = Rxn<Designer>();
  var reviews = <Review>[].obs; // قائمة التقييمات
  AddUpdateDeleteGetx(
    this.updateProfileUseCase,
    this.deleteProfileUseCase,
    this.addReviewUseCase,
    this.updateReviewUseCase,
    this.deleteReviewUseCase,
    this.addWorkUseCase,
    this.updateWorkUseCase,
    this.deleteWorkUseCase,
  );

  Future<void> updateDesigner(Designer designer) async {
    isLoading.value = true;

    final result = await updateProfileUseCase(designer);
    result.fold((failure) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DialogHelper.showErrorSnackBar(
            title: "Error", message: failure.message);
      });
    }, (profile) {
      debugPrint("Update Done Successfully!!");
    });
  }
}
