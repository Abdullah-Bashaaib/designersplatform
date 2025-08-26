import 'package:designers_platform/core/error/messages.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/usecases/login_usecase.dart';
import 'package:designers_platform/features/auth/domain/usecases/save_user.dart';
import 'package:designers_platform/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final LoginUsecase loginUsecase;
  final SignUpUsecase signUpUsecase;
  final SaveUserUsecase saveUserUsecase;

  AuthController(this.loginUsecase, this.signUpUsecase, this.saveUserUsecase);

  var isLoading = false.obs;
  var user = Rxn<User>();

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final result = await loginUsecase.call(email, password);
    result.fold((failure) => Get.snackbar('خطأ', serverError), (u) {
      user.value = u;
      saveUserUsecase.call(user.value!);
      Get.snackbar('Ok', 'تم الحفظ بنجاح');
    });
    isLoading.value = false;
  }

  Future<void> signUp(User userData) async {
    isLoading.value = true;
    final result = await signUpUsecase.call(userData);
    result.fold((failure) => Get.snackbar('خطأ', serverError), (u) async {
      user.value = u;
      await saveUserUsecase.call(u);
      Get.snackbar('Ok', 'تم الحفظ بنجاح');
    });
    isLoading.value = false;
  }
}
