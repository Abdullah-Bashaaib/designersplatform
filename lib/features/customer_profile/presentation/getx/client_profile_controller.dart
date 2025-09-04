import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/update_profile_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ClientProfileController extends GetxController {
  final UpdateProfileUsecase updateProfileUsecase;
  ClientProfileController(this.updateProfileUsecase);

  final userName = TextEditingController();
  final email = TextEditingController();
  var isLoading = false.obs;

  @override
  void onInit() {
    userName.text = 'salem';
    email.text = 'mslm66@gmail.com';
    super.onInit();
  }

  Future<void> saveProfile(Client client) async {
    isLoading.value = true;
    final result = await updateProfileUsecase.call(client);
    result.fold((f) => Get.snackbar('خطاء', f.message), (u) => u);
  }

  @override
  void onClose() {
    userName.dispose();
    email.dispose();
    super.onClose();
  }
}
