import 'package:designers_platform/core/database/sqflite_helper.dart';
import 'package:designers_platform/core/network/network_info.dart';
import 'package:designers_platform/features/auth/data/datasources/local_data.dart';
import 'package:designers_platform/features/auth/data/datasources/remote_data.dart';
import 'package:designers_platform/features/auth/domain/usecases/add_avatar.dart';
import 'package:designers_platform/features/auth/domain/usecases/clear_user.dart';
import 'package:designers_platform/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:designers_platform/features/auth/domain/usecases/login_usecase.dart';
import 'package:designers_platform/features/auth/domain/usecases/save_user.dart';
import 'package:designers_platform/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:designers_platform/features/auth/presentation/getx/auth_controller.dart';
import 'package:designers_platform/features/customer_profile/data/data_source/local_data_source.dart';
import 'package:designers_platform/features/customer_profile/data/data_source/remote_data_source.dart';
import 'package:designers_platform/features/customer_profile/data/repositories/client_profile_repo_imp.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/delete_profile.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/get_profile.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/update_profile_usecase.dart';
import 'package:designers_platform/features/customer_profile/presentation/getx/client_profile_controller.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'features/auth/data/repositories/auth_repository_imp.dart';
import 'features/auth/domain/repositories/auth_repository.dart';

class Injection {
  static Future<void> init() async {
    /// Core
    Get.put<NetworkInfo>(
        NetworkInfoImp(InternetConnectionChecker.createInstance()),
        permanent: true);

    /// SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(sharedPreferences, permanent: true);
    // ==========================================================================

    /// Database
    final db = await sqlHelper.openDB();
    Get.put<Database>(db, permanent: true);

    /// Data Source
    // Auth
    Get.lazyPut<RemoteDataSource>(() => RemoteDataSource());
    Get.lazyPut<LocalData>(() => LocalDataImp(Get.find<SharedPreferences>()));

    // Client Profile
    Get.lazyPut<ClientRemoteDataSource>(
      () => ClientRemoteDataSourceImp(),
    );
    Get.lazyPut<ClientLocalDataSource>(
      () => ClientLocalDataSourceImp(Get.find<Database>()),
    );
    // ============================================================================

    /// Repository
    // Auth
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImp(Get.find<NetworkInfo>(),
          Get.find<RemoteDataSource>(), Get.find<LocalData>()),
    );

    // Client Profile
    Get.lazyPut<ClientProfileRepo>(
      () => ClientProfileRepoImp(Get.find<ClientRemoteDataSource>(),
          Get.find<ClientLocalDataSource>(), Get.find<NetworkInfo>()),
    );
    // ==========================================================================

    /// Usecases
    // Auth
    Get.lazyPut<LoginUsecase>(() => LoginUsecase(Get.find<AuthRepository>()));
    Get.lazyPut<SignUpUsecase>(() => SignUpUsecase(Get.find<AuthRepository>()));
    Get.lazyPut<SaveUserUsecase>(
        () => SaveUserUsecase(Get.find<AuthRepository>()));
    Get.lazyPut<ClearUserUsecase>(
        () => ClearUserUsecase(Get.find<AuthRepository>()));
    Get.lazyPut<DeleteAccountUsecase>(
        () => DeleteAccountUsecase(Get.find<AuthRepository>()));
    Get.lazyPut<AddAvatarUsecase>(
        () => AddAvatarUsecase(Get.find<AuthRepository>()));

    // Client Profile
    Get.lazyPut<UpdateProfileUsecase>(
      () => UpdateProfileUsecase(Get.find<ClientProfileRepo>()),
    );
    Get.lazyPut<GetProfileUsecase>(
      () => GetProfileUsecase(Get.find<ClientProfileRepo>()),
    );
    Get.lazyPut<DeleteProfileUsecase>(
      () => DeleteProfileUsecase(Get.find<ClientProfileRepo>()),
    );

    /// GetX
    //Auth
    Get.put<AuthController>(
        AuthController(
            Get.find<LoginUsecase>(),
            Get.find<SignUpUsecase>(),
            Get.find<SaveUserUsecase>(),
            Get.find<ClearUserUsecase>(),
            Get.find<DeleteAccountUsecase>(),
            Get.find<AddAvatarUsecase>()),
        permanent: true);

    // Client Profile
    Get.put<ClientProfileController>(
        ClientProfileController(Get.find<UpdateProfileUsecase>(),
            Get.find<GetProfileUsecase>(), Get.find<DeleteProfileUsecase>()),
        permanent: true);

    ///========================== [ Feat: Designer Profile ] ==============================
    /// Data > datasource
  }
}
