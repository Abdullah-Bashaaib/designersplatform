import 'package:designers_platform/core/error/messages.dart';
import 'package:designers_platform/features/auth/domain/entities/user.dart';
import 'package:designers_platform/features/auth/domain/usecases/login_usecase.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final LoginUsecase loginUsecase;

  AuthController(this.loginUsecase);

  var isLoading = false.obs;
  var user = Rxn<User>();

  Future<void> login(String email, String password) async {
    final result = await loginUsecase.call(email, password);
    result.fold(
        (failure) => Get.snackbar('خطأ', serverError), (u) => user.value = u);
  }
}
