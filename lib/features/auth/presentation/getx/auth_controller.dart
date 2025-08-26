import 'package:designers_platform/core/error/messages.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/usecases/login_usecase.dart';
import 'package:designers_platform/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final LoginUsecase loginUsecase;
  final SignUpUsecase signUpUsecase;

  AuthController(this.loginUsecase, this.signUpUsecase);

  var isLoading = false.obs;
  var user = Rxn<User>();

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final result = await loginUsecase.call(email, password);
    result.fold(
        (failure) => Get.snackbar('خطأ', serverError), (u) => user.value = u);
    isLoading.value = false;
  }

  Future<void> signUp(User userData) async {
    isLoading.value = true;
    final result = await signUpUsecase.call(userData);
    result.fold(
        (failure) => Get.snackbar('خطأ', serverError), (u) => user.value = u);
        
    isLoading.value = false;
  }
}
