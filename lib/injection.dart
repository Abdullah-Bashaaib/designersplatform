import 'package:designers_platform/core/network/network_info.dart';
import 'package:designers_platform/features/auth/data/datasources/local_data.dart';
import 'package:designers_platform/features/auth/data/datasources/remote_data.dart';
import 'package:designers_platform/features/auth/domain/usecases/login_usecase.dart';
import 'package:designers_platform/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:designers_platform/features/auth/presentation/getx/auth_controller.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/data/repositories/auth_repository_imp.dart';
import 'features/auth/domain/repositories/auth_repository.dart';

class Injection {
  static void init() async {
    /// Core
    Get.put<NetworkInfo>(
        NetworkInfoImp(InternetConnectionChecker.createInstance()),
        permanent: true);

    /// SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(sharedPreferences, permanent: true);

    /// Data Source
    // Auth
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSource());
    Get.lazyPut<LocalData>(() => LocalDataImp(Get.find<SharedPreferences>()));

    /// Repository
    // Auth
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImp(Get.find<NetworkInfo>(),
          Get.find<RemoteDataSource>(), Get.find<LocalData>()),
    );

    /// Usecases
    // Auth
    Get.lazyPut<LoginUsecase>(() => LoginUsecase(Get.find<AuthRepository>()));
    Get.lazyPut<SignUpUsecase>(() => SignUpUsecase(Get.find<AuthRepository>()));

    /// GetX
    //Auth
    Get.put<AuthController>(
        AuthController(Get.find<LoginUsecase>(), Get.find<SignUpUsecase>()),
        permanent: true);
  }
}
