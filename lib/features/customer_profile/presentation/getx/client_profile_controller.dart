import 'dart:math';

import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/usecase/delete_avatar.dart';
import 'package:designers_platform/core/usecase/get_user.dart';
import 'package:designers_platform/core/usecase/logout.dart';
import 'package:designers_platform/core/usecase/save_user.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/presentation/pages/welcome_page.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/order_entity.dart';
import 'package:designers_platform/core/usecase/add_avatar.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/get_favorites.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/get_orders.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/get_profile.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/update_profile_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ClientProfileController extends GetxController {
  final UpdateProfileUsecase updateProfileUseCase;
  final GetProfileUsecase getProfileUsecase;
  final GetUserUseCase getUserUseCase;
  final GetFavoritesUsecase getFavoritesUsecase;
  final GetOrdersUsecase getOrdersUsecase;
  final AddAvatarUsecase addAvatarUsecase;
  final DeleteAvatarUsecase deleteAvatarUsecase;
  final SaveUserUsecase saveUserUsecase;
  final LogoutUsecase logoutUsecase;

  ClientProfileController(
    this.updateProfileUseCase,
    this.getProfileUsecase,
    this.getUserUseCase,
    this.getFavoritesUsecase,
    this.getOrdersUsecase,
    this.logoutUsecase,
    this.addAvatarUsecase,
    this.saveUserUsecase,
    this.deleteAvatarUsecase,
  );

  var userName = TextEditingController().obs;
  var email = TextEditingController().obs;
  var isLoading = false.obs;
  var clientProfile = Rxn<Client>();
  var favoritesList = <User>[].obs;
  var orderList = <OrderEntity>[].obs;
  var avatarUrl = CurrentUser.currentUser!.avatarUrl.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void getProfile() {
    isLoading.value = true;
    final result = getUserUseCase.call();
    result.fold(
        (f) =>
            DialogHelper.showErrorSnackBar(title: 'error', message: f.message),
        (c) {
      // clientProfile.value = c;
      userName.value.text = c.name;
      email.value.text = c.email;
      // print('===== ${c.name} =====');
    });
    isLoading.value = false;
  }

  Future<void> updateProfile(Client client) async {
    isLoading.value = true;
    final result = await updateProfileUseCase.call(client);
    result.fold((f) => Get.snackbar('خطاء', f.message), (u) => u);
    isLoading.value = false;
  }

  Future<void> getFavoritesList() async {
    final result = await getFavoritesUsecase.call();
    result.fold((f) {
      DialogHelper.showErrorDialog(title: 'خطأ', message: f.message);
    }, (r) {
      favoritesList.value = r;
    });
  }

  Future<void> getOrders() async {
    isLoading.value = true;
    final result = await getOrdersUsecase.call();
    result.fold((l) {}, (r) {
      orderList.value = r;
    });
    isLoading.value = false;
  }

  void addAvatar() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final imageUrl = await addAvatarUsecase.call(image);
    imageUrl.fold((failure) {
      DialogHelper.showErrorSnackBar(title: 'error', message: failure.message);
    }, (s) {
      avatarUrl.value = s;
      saveUserUsecase.call(CurrentUser.currentUser!);
      DialogHelper.showSuccessSnackBar(
          title: 'ok', message: updateAvatarMessage);
    });
  }

  Future<void> deleteAvatar() async {
    final result = await deleteAvatarUsecase.call();
    result.fold(
        (f) =>
            DialogHelper.showErrorSnackBar(title: 'error', message: f.message),
        (u) {
      DialogHelper.showSuccessSnackBar(
          title: 'ok', message: deleteAvatarMessage);
      avatarUrl.value = '';
    });
  }

  void logout() {
    logoutUsecase.call();
    Get.offAll(() => WelcomePage());
    DialogHelper.showSuccessSnackBar(title: 'تم', message: logoutMessage);
  }

  // @override
  // void onClose() {
  //   // userName.dispose();
  //   // email.dispose();
  //   super.onClose();
  // }
}
