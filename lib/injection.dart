import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:designers_platform/core/usecase/add_avatar.dart';
import 'package:designers_platform/core/usecase/delete_avatar.dart';
import 'package:designers_platform/core/usecase/get_user.dart';
import 'package:designers_platform/core/usecase/logout.dart';
import 'package:designers_platform/core/usecase/save_user.dart';
import 'package:designers_platform/features/auth/data/datasources/local_data.dart';
import 'package:designers_platform/features/auth/data/datasources/remote_data.dart';
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
import 'package:designers_platform/features/customer_profile/domain/usecases/get_profile.dart';
import 'package:designers_platform/features/customer_profile/domain/usecases/update_profile_usecase.dart';
import 'package:designers_platform/features/customer_profile/presentation/getx/client_profile_controller.dart';
import 'package:designers_platform/features/designer_profile/data/datasource/local_data_source/designer_local_data_source.dart';
import 'package:designers_platform/features/designer_profile/data/datasource/local_data_source/review_local_data_source.dart';
import 'package:designers_platform/features/designer_profile/data/datasource/local_data_source/work_local_data_source.dart';
import 'package:designers_platform/features/designer_profile/data/datasource/remote_data_source/designer_remote_data_source.dart';
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
import 'package:designers_platform/features/designer_profile/presentation/getx/getData_controller_getx.dart';
import 'package:designers_platform/features/order_management/data/datasource/order_remote.dart';
import 'package:designers_platform/features/order_management/data/repo/order_repo_imp.dart';
import 'package:designers_platform/features/order_management/domain/repo/order_repo.dart';
import 'package:designers_platform/features/order_management/domain/usecase/add_order.dart';
import 'package:designers_platform/features/order_management/domain/usecase/get_orders.dart';
import 'package:designers_platform/features/order_management/presentation/getx/chat_getx.dart';
import 'package:designers_platform/features/order_management/presentation/getx/order_getx.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import 'core/data/network_info_impl.dart';
import 'core/domain/i_internet_info.dart';
import 'core/presentation/services/network_service.dart';
import 'features/auth/data/repositories/auth_repository_imp.dart';
import 'features/auth/domain/repositories/auth_repository.dart';

class Injection {
  static Future<void> init() async {
    /// Core
    // Get.put<NetworkInfo>(
    //     NetworkInfoImp(InternetConnectionChecker.createInstance()),
    //     permanent: true);
    // network listening
    // --- Network Listener Service (الكود الصحيح) ---

// 1. نسجل الباكج نفسه.
//    لاحظ () بعد createInstance، لأننا نريد "نتيجة" الدالة وليس الدالة نفسها
    Get.lazyPut<InternetConnectionChecker>(
      () => InternetConnectionChecker.createInstance(),
      fenix: true,
    );

// 2. نسجل "الواجهة الجديدة" (INetworkInfo) مع "التنفيذ الجديد" (NetworkInfoImpl)
//    (تأكد من أن NetworkInfoImpl يستورد INetworkInfo)
    Get.lazyPut<INetworkInfo>(
      () => NetworkInfoImpl(Get.find<InternetConnectionChecker>()),
      fenix: true,
    );

// 3. نسجل خدمة GetX التي تشغّل اللسنر أوتوماتيكياً
    Get.lazyPut(() => NetworkService(), fenix: true);
    final uuid = Uuid();
    Get.lazyPut<Uuid>(() => uuid);

    /// SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(sharedPreferences, permanent: true);
    // ==========================================================================

    /// Firebase
    final dbF = FirebaseFirestore.instance;
    Get.put<FirebaseFirestore>(dbF, permanent: true);

    /// Supabase
    final dbS = Supabase.instance.client;
    Get.put<SupabaseClient>(dbS, permanent: true);

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
      () => AuthRepositoryImp(Get.find<INetworkInfo>(),
          Get.find<RemoteDataSource>(), Get.find<LocalData>()),
    );

    // ==========================================================================

    /// Use cases
    Get.lazyPut<LoginUsecase>(() => LoginUsecase(Get.find<AuthRepository>()));
    Get.lazyPut<SignUpUsecase>(() => SignUpUsecase(Get.find<AuthRepository>()));

    Get.lazyPut<DeleteAccountUsecase>(
        () => DeleteAccountUsecase(Get.find<AuthRepository>()));

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
            Get.find<Uuid>(),
            Get.find<GetUserUseCase>(),
            Get.find<ForgetPasswordUsecase>()),
        permanent: true);

    ///========================== [ Feat: Client Profile ] ==============================
    /// Data Source
    Get.lazyPut<ClientRemoteDataSource>(
      fenix: true,
      () => ClientRemoteDataSourceImp(
          Get.find<SupabaseClient>(), Get.find<FirebaseFirestore>()),
    );
    Get.lazyPut<ClientLocalDataSource>(
      fenix: true,
      () => ClientLocalDataSourceImp(Get.find<SharedPreferences>()),
    );

    /// Repo
    Get.lazyPut<ClientProfileRepo>(
      fenix: true,
      () => ClientProfileRepoImp(Get.find<ClientRemoteDataSource>(),
          Get.find<ClientLocalDataSource>(), Get.find<INetworkInfo>()),
    );

    /// Usecases
    Get.lazyPut<UpdateProfileUsecase>(
      fenix: true,
      () => UpdateProfileUsecase(Get.find<ClientProfileRepo>()),
    );
    Get.lazyPut<GetProfileUsecase>(
      fenix: true,
      () => GetProfileUsecase(Get.find<ClientProfileRepo>()),
    );

    Get.lazyPut<GetFavoritesUsecase>(
        fenix: true, () => GetFavoritesUsecase(Get.find<ClientProfileRepo>()));

    Get.lazyPut<AddAvatarUsecase>(
        fenix: true, () => AddAvatarUsecase(Get.find<ClientProfileRepo>()));

    Get.lazyPut<SaveUserUsecase>(
        fenix: true, () => SaveUserUsecase(Get.find<ClientProfileRepo>()));

    Get.lazyPut<DeleteAvatarUsecase>(
        fenix: true, () => DeleteAvatarUsecase(Get.find<ClientProfileRepo>()));

    /// GetX
    Get.lazyPut<ClientProfileController>(
        () => ClientProfileController(
              Get.find<UpdateProfileUsecase>(),
              Get.find<GetProfileUsecase>(),
              Get.find<GetUserUseCase>(),
              Get.find<GetFavoritesUsecase>(),
              Get.find<LogoutUsecase>(),
              Get.find<AddAvatarUsecase>(),
              Get.find<SaveUserUsecase>(),
              Get.find<DeleteAvatarUsecase>(),
            ),
        fenix: true);

    ///========================== [ Feat: Designer Profile ] ==============================
    ///Data Source

    ///Data Local
    Get.lazyPut(() => Get.find<SharedPreferences>());
    Get.lazyPut(
      () => DesignerLocalDataSourceImpBySharedPref(
        sharedPreferences: Get.find<SharedPreferences>(),
      ),
    );
    Get.lazyPut(() => DesignerRemoteDataSourceImpByFirebase(
        firestore: Get.find<FirebaseFirestore>()));
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
          Get.find<INetworkInfo>(),
          Get.find<DesignerRemoteDataSourceImpByFirebase>()),
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
    Get.lazyPut<GetDataControllerGetx>(
      fenix: true,
      () => GetDataControllerGetx(
          Get.find<GetProfileUseCase>(),
          Get.find<GetReviewUseCase>(),
          Get.find<GetWorkUseCase>(),
          Get.find<LogoutUsecase>(),
          Get.find<SharedPreferences>(),
          Get.find<AddReviewUseCase>(),
          Get.find<AddWorkUseCase>(),
          Get.find<DeleteProfileUseCase>(),
          Get.find<DeleteReviewUseCase>(),
          Get.find<DeleteWorkUseCase>(),
          Get.find<UpdateProfileUseCase>(),
          Get.find<UpdateReviewUseCase>(),
          Get.find<UpdateWorkUseCase>(),
          Get.find<AddAvatarUsecase>(),
          Get.find<Uuid>(),
          Get.find<AddOrderUsecase>()),
    );

    ///========================== [ Feat: Order Management ] ==============================

    /// data source
    Get.lazyPut<OrderRemote>(
      fenix: true,
      () => OrderRemoteImp(
        Get.find<FirebaseFirestore>(),
        Get.find<SharedPreferences>(),
      ),
    );

    /// repo
    Get.lazyPut<OrderRepo>(
        fenix: true,
        () => OrderRepoImp(Get.find<OrderRemote>(), Get.find<INetworkInfo>()));

    /// Usecase
    Get.lazyPut<AddOrderUsecase>(() => AddOrderUsecase(Get.find<OrderRepo>()));
    Get.lazyPut<GetOrdersUsecase>(
        fenix: true, () => GetOrdersUsecase(Get.find<OrderRepo>()));

    /// Getx
    Get.lazyPut<OrderGetx>(
      fenix: true,
      () => OrderGetx(
        Get.find<GetOrdersUsecase>(),
      ),
    );
    Get.lazyPut<ChatOrderGetX>(
      fenix: true,
      () => ChatOrderGetX(),
    );
  }
}
