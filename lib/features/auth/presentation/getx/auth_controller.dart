import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/usecases/add_avatar.dart';
import 'package:designers_platform/features/auth/domain/usecases/clear_user.dart';
import 'package:designers_platform/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:designers_platform/features/auth/domain/usecases/login_usecase.dart';
import 'package:designers_platform/features/auth/domain/usecases/save_user.dart';
import 'package:designers_platform/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final LoginUsecase loginUsecase;
  final SignUpUsecase signUpUsecase;
  final SaveUserUsecase saveUserUsecase;
  final ClearUserUsecase clearUserUsecase;
  final DeleteAccountUsecase deleteAccountUsecase;
  final AddAvatarUsecase addAvatarUsecase;

  AuthController(this.loginUsecase, this.signUpUsecase, this.saveUserUsecase,
      this.clearUserUsecase, this.deleteAccountUsecase, this.addAvatarUsecase);

  var isLoading = false.obs;
  var user = Rxn<User>();
  var role = Rxn<String>();
  var obscureText = true.obs;
  var avatarUrl = Rxn<String>();

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final result = await loginUsecase.call(email, password);
    result.fold(
        (failure) => DialogHelper.showErrorSnackBar(
            title: 'error', message: failure.message), (u) {
      user.value = u;
      saveUserUsecase.call(u);
      CurrentUser.currentUser = u;
      DialogHelper.showSuccessSnackBar(title: 'ok', message: 'message');
    });
    isLoading.value = false;
  }

  Future<void> signUp(User userData) async {
    isLoading.value = true;
    final result = await signUpUsecase.call(userData);
    result.fold((failure) => Get.snackbar('خطأ', failure.message), (u) async {
      user.value = u;
      await saveUserUsecase.call(u);
      Get.snackbar('Ok', 'تم الحفظ بنجاح');
    });
    isLoading.value = false;
  }

  Future<void> clearUser() async {
    await clearUserUsecase.call();
  }

  Future<void> deleteAccount() async {
    final result = await deleteAccountUsecase.call();
    if (result) {
      Get.snackbar('Ok', 'تم حذف الحساب بنجاح');
    } else {
      Get.snackbar('error', 'خطا في حذف الحساب');
    }
  }

  Future<void> addAvatar(String filePath) async {
    isLoading.value = true;
    final result =
        await addAvatarUsecase.call(CurrentUser.currentUser!.id!, filePath);
    result.fold(
        (f) =>
            DialogHelper.showErrorSnackBar(title: 'خطاء', message: f.message),
        (s) {
      avatarUrl.value = s;
      DialogHelper.showSuccessSnackBar(title: 'ok', message: addSuccess);
    });
  }
}
