import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/usecase/get_user.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:designers_platform/features/auth/domain/usecases/forget_password.dart';
import 'package:designers_platform/features/auth/domain/usecases/login_usecase.dart';
import 'package:designers_platform/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:designers_platform/features/auth/presentation/pages/splash.dart';
import 'package:designers_platform/features/customer_profile/presentation/screens/view_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../designer_profile/presentation/views/screens/profile_screen.dart';
import '../pages/welcome_page.dart';

class AuthController extends GetxController {
  final LoginUsecase loginUsecase;
  final SignUpUsecase signUpUsecase;
  final DeleteAccountUsecase deleteAccountUsecase;
  final GetUserUseCase getUserUseCase;
  final ForgetPasswordUsecase forgetPasswordUsecase;
  final Uuid uuid;

  AuthController(
      this.loginUsecase,
      this.signUpUsecase,
      this.deleteAccountUsecase,
      this.uuid,
      this.getUserUseCase,
      this.forgetPasswordUsecase);

  var isLoading = false.obs;
  var role = Rxn<String>();
  var obscureText = true.obs;
  var avatarUrl = Rxn<String>();
  var user = Rxn<User>();
  var email = Rxn<String>();

  @override
  void onInit() {
    role.value = 'عميل';
    super.onInit();
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final result = await loginUsecase.call(email, password);
    result.fold(
      (failure) {
        DialogHelper.showErrorSnackBar(
            title: 'error', message: failure.message);
        // print(failure.message);
      },
      (u) {
        // user.value = u;
        CurrentUser.currentUser = u;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAll(() => SplashScreen());
          // DialogHelper.showSuccessSnackBar(title: 'ok', message: 'message');
        });
      },
    );
    isLoading.value = false;
  }

  Future<void> signUp(
      String name, String email, String password, String role) async {
    User newUser = User(
      id: uuid.v4(),
      name: name,
      email: email,
      role: role,
      keywords: [],
    );
    isLoading.value = true;

    final result = await signUpUsecase.call(newUser, password);
    result.fold((failure) {
      DialogHelper.showErrorSnackBar(title: 'خطأ', message: failure.message);
      // print(failure.message);
    }, (u) async {
      DialogHelper.showSuccessSnackBar(title: 'ok', message: saveMessage);
      CurrentUser.currentUser = u;
      // print(CurrentUser.currentUser);
      WidgetsBinding.instance
          .addPostFrameCallback((_) => Get.offAll(() => SplashScreen()));
    });
    isLoading.value = false;
  }

  Future<void> deleteAccount() async {
    final result = await deleteAccountUsecase.call();
    result.fold(
        (l) => DialogHelper.showErrorSnackBar(title: 'خطأ', message: l.message),
        (r) => DialogHelper.showSuccessDialog(
            message: deleteAccountMessage, title: ''));
  }

  Future<void> forgotPassword(String email) async {
    isLoading.value = true;
    final result = await forgetPasswordUsecase.call(email);
    result.fold(
        (failure) => DialogHelper.showErrorSnackBar(
            title: 'خطأ', message: failure.message), (unit) {
      DialogHelper.showSuccessSnackBar(
          title: 'تم', message: passwordVerifiedSuccessMessage);
      WidgetsBinding.instance
          .addPostFrameCallback((_) => Get.offAll(() => WelcomePage()));
    });
    isLoading.value = false;
  }
}
