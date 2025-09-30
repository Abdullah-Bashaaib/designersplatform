import 'package:designers_platform/core/usecase/get_user.dart';
import 'package:designers_platform/core/usecase/logout.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/presentation/pages/welcome_page.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/client.dart';
import 'package:designers_platform/features/customer_profile/domain/entities/order_entity.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/get_favorites.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/get_orders.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/get_profile.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/update_profile_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ClientProfileController extends GetxController {
  final UpdateProfileUsecase updateProfileUseCase;
  final GetProfileUsecase getProfileUsecase;
  final GetUserUseCase getUserUseCase;
  final GetFavoritesUsecase getFavoritesUsecase;
  final GetOrdersUsecase getOrdersUsecase;
  final LogoutUsecase logoutUsecase;

  ClientProfileController(
      this.updateProfileUseCase,
      this.getProfileUsecase,
      this.getUserUseCase,
      this.getFavoritesUsecase,
      this.getOrdersUsecase,
      this.logoutUsecase);

  var userName = TextEditingController().obs;
  var email = TextEditingController().obs;
  var isLoading = false.obs;
  var clientProfile = Rxn<Client>();
  var favoritesList = <User>[].obs;
  var orderList = <OrderEntity>[].obs;

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
      print('===== ${c.name} =====');
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

  void logout() {
    logoutUsecase.call();
    Get.offAll(() => WelcomePage());
    DialogHelper.showSuccessSnackBar(title: 'تم', message: logoutMessage);
  }

  @override
  void onClose() {
    // userName.dispose();
    // email.dispose();
    super.onClose();
  }
}
