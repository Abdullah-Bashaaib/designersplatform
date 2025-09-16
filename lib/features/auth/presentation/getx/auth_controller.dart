import 'package:designers_platform/core/current_user.dart';
import 'package:designers_platform/core/utils/custom_dialog_getx.dart';
import 'package:designers_platform/core/utils/messages.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/usecases/add_avatar.dart';
import 'package:designers_platform/features/auth/domain/usecases/clear_user.dart';
import 'package:designers_platform/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:designers_platform/features/auth/domain/usecases/login_usecase.dart';
import 'package:designers_platform/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:designers_platform/features/customer_profile/presentation/screens/edit_client_profile.dart';
import 'package:designers_platform/features/customer_profile/presentation/screens/view_profile.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AuthController extends GetxController {
  final LoginUsecase loginUsecase;
  final SignUpUsecase signUpUsecase;
  final ClearUserUsecase clearUserUsecase;
  final DeleteAccountUsecase deleteAccountUsecase;
  final AddAvatarUsecase addAvatarUsecase;
  final Uuid uuid;

  AuthController(this.loginUsecase, this.signUpUsecase, this.clearUserUsecase,
      this.deleteAccountUsecase, this.addAvatarUsecase, this.uuid);

  var isLoading = false.obs;
  // var user = Rxn<User>();
  var role = Rxn<String>();
  var obscureText = true.obs;
  var avatarUrl = Rxn<String>();

  @override
  void onInit() {
    role.value = 'عميل';
    super.onInit();
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final result = await loginUsecase.call(email, password);
    result.fold(
        (failure) => DialogHelper.showErrorSnackBar(
            title: 'error', message: failure.message), (u) {
      // user.value = u;
      CurrentUser.currentUser = u;
      DialogHelper.showSuccessSnackBar(title: 'ok', message: 'message');
      Get.offAll(() => ViewProfile());
    });
    isLoading.value = false;
  }

  Future<void> signUp(
      String name, String email, String password, String role) async {
    User newUser = User(
        id: uuid.v4(),
        name: name,
        email: email,
        password: password,
        role: role);
    isLoading.value = true;
    final result = await signUpUsecase.call(newUser);
    result.fold((failure) {
      DialogHelper.showErrorSnackBar(title: 'خطأ', message: failure.message);
      print(failure.message);
    }, (u) async {
      // user = u as Rxn<User>;
      DialogHelper.showSuccessSnackBar(title: 'ok', message: saveMessage);
      CurrentUser.currentUser = u;
      print(CurrentUser.currentUser);
      Get.offAll(() => ViewProfile());
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
        await addAvatarUsecase.call(CurrentUser.currentUser!.id, filePath);
    result.fold(
        (f) =>
            DialogHelper.showErrorSnackBar(title: 'خطاء', message: f.message),
        (s) {
      avatarUrl.value = s;
      DialogHelper.showSuccessSnackBar(title: 'ok', message: addSuccess);
    });
  }
}
