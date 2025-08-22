import 'package:designers_platform/core/network/network_info.dart';
import 'package:designers_platform/features/auth/data/datasources/remote_data.dart';
import 'package:designers_platform/features/auth/domain/usecases/login_usecase.dart';
import 'package:designers_platform/features/auth/presentation/getx/auth_controller.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/auth/data/repositories/auth_repository_imp.dart';
import 'features/auth/domain/repositories/auth_repository.dart';

class Injection {
  static void init() {
    /// Core
    Get.put<NetworkInfo>(
        NetworkInfoImp(InternetConnectionChecker.createInstance()),
        permanent: true);

    /// Data Source
    // Auth
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSource());

    /// Repository
    // Auth
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImp(
          Get.find<NetworkInfo>(), Get.find<RemoteDataSource>()),
    );

    /// Usecases
    // Auth
    Get.lazyPut<LoginUsecase>(() => LoginUsecase(Get.find<AuthRepository>()));

    /// GetX
    //Auth
    Get.put<AuthController>(AuthController(Get.find<LoginUsecase>()),
        permanent: true);
  }
}
