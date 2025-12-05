import 'dart:developer';

import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/usecase/add_avatar.dart';
import 'package:designers_platform/core/utils/app_functions.dart';
import 'package:designers_platform/core/utils/key_app.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/review_usecase/get_review_use_case.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/work_usecase/get_work_use_case.dart';
import 'package:designers_platform/features/order_management/domain/entity/orders.dart';
import 'package:designers_platform/features/order_management/domain/usecase/add_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

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
  final Uuid uuid;
  // Designer
  final UpdateProfileUseCase updateProfileUseCase;
  final DeleteProfileUseCase deleteProfileUseCase;
  final AddOrderUsecase addOrderUsecase;
  // Review
  final AddReviewUseCase addReviewUseCase;
  final UpdateReviewUseCase updateReviewUseCase;
  final DeleteReviewUseCase deleteReviewUseCase;
  // Work
  final AddWorkUseCase addWorkUseCase;
  final UpdateWorkUseCase updateWorkUseCase;
  final DeleteWorkUseCase deleteWorkUseCase;
  // avatar use case
  final AddAvatarUsecase addAvatarUsecase;

  RxBool isLoading = true.obs;
  var isLoadingAddOrder = false.obs;
  var designerR = Rxn<Designer>();
  var reviews = <Review>[].obs;
  var works = <Work>[].obs;
  // var avatarUrl = CurrentUser.currentUser!.avatarUrl;

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
    this.addAvatarUsecase,
    this.uuid,
    this.addOrderUsecase,
  );

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    isLoading.value = true;

    await Future.wait([
      getDataDesignerProfile(),
      getDataReviews(),
      getDataWorks(),
    ]);

    isLoading.value = false;
  }

  /// get the designer profile
  Future<void> getDataDesignerProfile() async {
    final id = sharedPreferences.getString(KeySharedPref.kUserId);
    log("----------------------------------> The user id : $id");
    if (id == null) {
      Get.offAll(() => WelcomePage());
      DialogHelper.showErrorSnackBar(
        title: "خطأ",
        message: "لم يتم العثور على معرف المستخدم",
      );
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
  }

  /// get all works of designer
  Future<void> getDataWorks() async {
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
  }

  Future<void> updateDesigner(Designer designer) async {
    isLoading.value = true;
    // final keywords = AppFunctions.generateKeywords(designer.name);
    // designer.keywords = keywords;
    final result = await updateProfileUseCase(designer);
    result.fold((failure) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DialogHelper.showErrorSnackBar(
            title: "خطأ!!", message: failure.message);
      });
    }, (profile) {
      getDataDesignerProfile();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DialogHelper.showSuccessSnackBar(
            title: "نجاح!!", message: "تمت التعديل بنجاح!");
      });
    });
    isLoading.value = false;
  }

  /// edit avatar designer
  void editAvatar() async {
    isLoading.value = true;
    final picker = ImagePicker();

    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        isLoading.value = false;
        return;
      }

      final result = await addAvatarUsecase(image);

      result.fold(
        (failure) {
          DialogHelper.showErrorSnackBar(
            title: "خطأ!!",
            message: failure.message,
          );
        },
        (avatarUrl) {
          // ✅ تحديث القيمة بشكل صحيح لتفعيل الـ Obx
          designerR.update((designer) {
            designer?.avatarUrl = avatarUrl;
          });
          DialogHelper.showSuccessSnackBar(
            title: "نجاح!!",
            message: "تم التعديل بنجاح!",
          );
          log("-------------------------> new avatarUrl : $avatarUrl");
        },
      );
    } catch (e) {
      DialogHelper.showErrorSnackBar(
        title: "خطأ!!",
        message: "حدث خطأ أثناء اختيار الصورة: $e",
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// add order to designer
  Future<void> addOrder(
      Designer designer, String type, String description) async {
    isLoadingAddOrder.value = true;
    final order = OrderEntity(
        id: uuid.v4(),
        clientId: CurrentUser.currentUser!.id,
        clientName: CurrentUser.currentUser!.name,
        designerId: designer.id,
        designerName: designer.name,
        designType: type,
        description: description,
        status: 'قيد الانتظار',
        createAt: DateTime.now());

    final result = await addOrderUsecase.call(order);
    result.fold(
        (f) => DialogHelper.showErrorSnackBar(
            title: 'خطـــأ!', message: f.message), (u) {
      DialogHelper.showSuccessSnackBar(
          title: 'نجــــاح!', message: addOrderMessage);
    });
    isLoadingAddOrder.value = false;
  }

  /// log out methods
  void logout() {
    logoutUsecase.call();
    Get.offAll(() => WelcomePage());
    DialogHelper.showSuccessSnackBar(title: 'تم', message: logoutMessage);
  }
}
