import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/delete_profile.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/get_profile.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/update_profile_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ClientProfileController extends GetxController {
  final UpdateProfileUsecase updateProfileUseCase;
  final GetProfileUsecase getProfileUsecase;
  final DeleteProfileUsecase deleteProfileUseCase;

  ClientProfileController(this.updateProfileUseCase, this.getProfileUsecase,
      this.deleteProfileUseCase);

  final userName = TextEditingController();
  final email = TextEditingController();
  var isLoading = false.obs;
  var clientProfile = Rxn<Client>();

  @override
  void onInit() {
    userName.text = 'salem';
    email.text = 'mslm66@gmail.com';
    super.onInit();
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    final result = await getProfileUsecase.call();
    result.fold(
        (f) =>
            DialogHelper.showErrorSnackBar(title: 'error', message: f.message),
        (c) {
      clientProfile.value = c;
    });
    isLoading.value = false;
  }

  Future<void> updateProfile(Client client) async {
    isLoading.value = true;
    final result = await updateProfileUseCase.call(client);
    result.fold((f) => Get.snackbar('خطاء', f.message), (u) => u);
    isLoading.value = false;
  }

  Future<void> deleteProfile() async {
    final result = await deleteProfileUseCase.call();
    result.fold(
        (f) => DialogHelper.showErrorSnackBar(title: 'خطا', message: f.message),
        (r) => DialogHelper.showSuccessSnackBar(title: 'ok', message: logout));
  }

  @override
  void onClose() {
    userName.dispose();
    email.dispose();
    super.onClose();
  }
}
