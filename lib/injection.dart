import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designers_platform/core/database/sqflite_helper.dart';
import 'package:designers_platform/core/network/network_info.dart';
import 'package:designers_platform/core/usecase/get_user.dart';
import 'package:designers_platform/core/usecase/logout.dart';
import 'package:designers_platform/features/auth/data/datasources/local_data.dart';
import 'package:designers_platform/features/auth/data/datasources/remote_data.dart';
import 'package:designers_platform/features/auth/domain/usecases/add_avatar.dart';
import 'package:designers_platform/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:designers_platform/features/auth/domain/usecases/forget_password.dart';
import 'package:designers_platform/features/auth/domain/usecases/login_usecase.dart';
import 'package:designers_platform/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:designers_platform/features/auth/presentation/getx/auth_controller.dart';
import 'package:designers_platform/features/customer_profile/data/data_source/local_data_source.dart';
import 'package:designers_platform/features/customer_profile/data/data_source/remote_data_source.dart';
import 'package:designers_platform/features/customer_profile/data/repositories/client_profile_repo_imp.dart';
import 'package:designers_platform/features/customer_profile/domain/repositories/client_profile_repo.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/get_favorites.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/get_orders.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/get_profile.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/update_profile_usecase.dart';
import 'package:designers_platform/features/customer_profile/presentation/getx/client_profile_controller.dart';
import 'package:designers_platform/features/designer_profile/data/datasource/local_data_source/designer_local_data_source.dart';
import 'package:designers_platform/features/designer_profile/data/datasource/local_data_source/review_local_data_source.dart';
import 'package:designers_platform/features/designer_profile/data/datasource/local_data_source/work_local_data_source.dart';
import 'package:designers_platform/features/designer_profile/data/repositories/dseigner_repo_imp.dart';
import 'package:designers_platform/features/designer_profile/data/repositories/review_repo_imp.dart';
import 'package:designers_platform/features/designer_profile/data/repositories/work_repo_imp.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/designer_usecase/delete_profile_usecase.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/designer_usecase/get_profile_usecase.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/designer_usecase/update_profile_usecase.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/review_usecase/add_review_use_case.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/review_usecase/delete_review_use_case.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/review_usecase/get_review_use_case.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/review_usecase/update_review_use_case.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/work_usecase/add_work_use_case.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/work_usecase/delete_work_use_case.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/work_usecase/get_work_use_case.dart';
import 'package:designers_platform/features/designer_profile/domain/usecases/work_usecase/update_work_use_case.dart';
import 'package:designers_platform/features/designer_profile/presentation/getx/add_update_delete_getx.dart';
import 'package:designers_platform/features/designer_profile/presentation/getx/getData_controller_getx.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import 'features/auth/data/repositories/auth_repository_imp.dart';
import 'features/auth/domain/repositories/auth_repository.dart';

class Injection {
  static Future<void> init() async {
    /// Core
    Get.put<NetworkInfo>(
        NetworkInfoImp(InternetConnectionChecker.createInstance()),
        permanent: true);
    final uuid = Uuid();
    Get.lazyPut<Uuid>(() => uuid);

    /// SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(sharedPreferences, permanent: true);
    // ==========================================================================

    /// Database
    final db = await sqlHelper.openDB();
    Get.put<Database>(db, permanent: true);

    /// Firebase
    final dbF = FirebaseFirestore.instance;
    Get.put<FirebaseFirestore>(dbF, permanent: true);

    /// Usecase
    Get.lazyPut<GetUserUseCase>(
        () => GetUserUseCase(Get.find<AuthRepository>()));
    Get.lazyPut<LogoutUsecase>(() => LogoutUsecase(Get.find<AuthRepository>()),
        fenix: true);

    ///========================== [ Feat: Auth ] ==============================
    /// Data Source
    Get.lazyPut<RemoteDataSource>(
        () => RemoteDataSource(Get.find<FirebaseFirestore>()));
    Get.lazyPut<LocalData>(() => LocalDataImp(Get.find<SharedPreferences>()));

    // ============================================================================

    /// Repository
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImp(Get.find<NetworkInfo>(),
          Get.find<RemoteDataSource>(), Get.find<LocalData>()),
    );

    // ==========================================================================

    /// Use cases
    Get.lazyPut<LoginUsecase>(() => LoginUsecase(Get.find<AuthRepository>()));
    Get.lazyPut<SignUpUsecase>(() => SignUpUsecase(Get.find<AuthRepository>()));

    Get.lazyPut<DeleteAccountUsecase>(
        () => DeleteAccountUsecase(Get.find<AuthRepository>()));
    Get.lazyPut<AddAvatarUsecase>(
        () => AddAvatarUsecase(Get.find<AuthRepository>()));
    Get.lazyPut<GetUserUseCase>(
        () => GetUserUseCase(Get.find<AuthRepository>()));
    Get.lazyPut<ForgetPasswordUsecase>(
        () => ForgetPasswordUsecase(Get.find<AuthRepository>()));

    /// GetX
    Get.put<AuthController>(
        AuthController(
            Get.find<LoginUsecase>(),
            Get.find<SignUpUsecase>(),
            Get.find<DeleteAccountUsecase>(),
            Get.find<AddAvatarUsecase>(),
            Get.find<Uuid>(),
            Get.find<GetUserUseCase>(),
            Get.find<ForgetPasswordUsecase>()),
        permanent: true);

    ///========================== [ Feat: Client Profile ] ==============================
    /// Data Source
    Get.lazyPut<ClientRemoteDataSource>(
      () => ClientRemoteDataSourceImp(),
    );
    Get.lazyPut<ClientLocalDataSource>(
      () => ClientLocalDataSourceImp(
          Get.find<Database>(), Get.find<SharedPreferences>()),
    );

    /// Repo
    Get.lazyPut<ClientProfileRepo>(
      () => ClientProfileRepoImp(Get.find<ClientRemoteDataSource>(),
          Get.find<ClientLocalDataSource>(), Get.find<NetworkInfo>()),
    );

    /// Usecases
    Get.lazyPut<UpdateProfileUsecase>(
      () => UpdateProfileUsecase(Get.find<ClientProfileRepo>()),
    );
    Get.lazyPut<GetProfileUsecase>(
      () => GetProfileUsecase(Get.find<ClientProfileRepo>()),
    );

    Get.lazyPut<GetFavoritesUsecase>(
        () => GetFavoritesUsecase(Get.find<ClientProfileRepo>()));

    Get.lazyPut<GetOrdersUsecase>(
        () => GetOrdersUsecase(Get.find<ClientProfileRepo>()));

    /// GetX
    Get.put<ClientProfileController>(
        ClientProfileController(
          Get.find<UpdateProfileUsecase>(),
          Get.find<GetProfileUsecase>(),
          Get.find<GetUserUseCase>(),
          Get.find<GetFavoritesUsecase>(),
          Get.find<GetOrdersUsecase>(),
          Get.find<LogoutUsecase>(),
        ),
        permanent: true);

    ///========================== [ Feat: Designer Profile ] ==============================
    ///Data Source
    Get.put(SQLHelper());

    ///Data Local
    Get.lazyPut(() => Get.find<SharedPreferences>());
    Get.lazyPut(
      () => DesignerLocalDataSourceImpBySharedPref(
        sharedPreferences: Get.find<SharedPreferences>(),
      ),
    );
    Get.lazyPut(
      () => ReviewLocalDataSourceImpBySql(
        sharedPreferences: Get.find<SharedPreferences>(),
      ),
    );
    Get.lazyPut(
      () => WorkLocalDataSourceImpBySql(
        sharedPreferences: Get.find<SharedPreferences>(),
      ),
    );

    /// Repo
    Get.lazyPut(
      () => DesignerRepoImp(
        Get.find<DesignerLocalDataSourceImpBySharedPref>(),
      ),
    );
    Get.lazyPut(
      () => ReviewRepoImp(
        Get.find<ReviewLocalDataSourceImpBySql>(),
      ),
    );
    Get.lazyPut(
      () => WorkRepoImp(
        Get.find<WorkLocalDataSourceImpBySql>(),
      ),
    );

    /// UseCase
    Get.put<GetProfileUseCase>(
      GetProfileUseCase(
        designerRepository: Get.find<DesignerRepoImp>(),
      ),
    );
    Get.put<GetReviewUseCase>(
      GetReviewUseCase(
        reviewRepository: Get.find<ReviewRepoImp>(),
      ),
    );
    Get.put<GetWorkUseCase>(
      GetWorkUseCase(
        workRepository: Get.find<WorkRepoImp>(),
      ),
    );
    Get.lazyPut(
      () => UpdateProfileUseCase(
        designerRepository: Get.find<DesignerRepoImp>(),
      ),
    );
    Get.lazyPut(
      () => DeleteProfileUseCase(
        designerRepository: Get.find<DesignerRepoImp>(),
      ),
    );
    Get.lazyPut(
      () => AddReviewUseCase(
        reviewRepository: Get.find<ReviewRepoImp>(),
      ),
    );
    Get.lazyPut(
      () => UpdateReviewUseCase(
        reviewRepository: Get.find<ReviewRepoImp>(),
      ),
    );
    Get.lazyPut(
      () => DeleteReviewUseCase(
        reviewRepository: Get.find<ReviewRepoImp>(),
      ),
    );
    Get.lazyPut(
      () => AddWorkUseCase(
        workRepository: Get.find<WorkRepoImp>(),
      ),
    );
    Get.lazyPut(
      () => UpdateWorkUseCase(
        workRepository: Get.find<WorkRepoImp>(),
      ),
    );
    Get.lazyPut(
      () => DeleteWorkUseCase(
        workRepository: Get.find<WorkRepoImp>(),
      ),
    );

    /// GetX Controller
    Get.put<GetDataControllerGetx>(
      GetDataControllerGetx(
        Get.find<GetProfileUseCase>(),
        Get.find<GetReviewUseCase>(),
        Get.find<GetWorkUseCase>(),
        Get.find<LogoutUsecase>(),
        Get.find<SharedPreferences>(),
      ),
      permanent: true,
    );

    Get.put<AddUpdateDeleteGetx>(AddUpdateDeleteGetx(
      Get.find<UpdateProfileUseCase>(),
      Get.find<DeleteProfileUseCase>(),
      Get.find<AddReviewUseCase>(),
      Get.find<UpdateReviewUseCase>(),
      Get.find<DeleteReviewUseCase>(),
      Get.find<AddWorkUseCase>(),
      Get.find<UpdateWorkUseCase>(),
      Get.find<DeleteWorkUseCase>(),
    ));
  }
}
