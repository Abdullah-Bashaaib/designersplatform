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
import 'package:designers_platform/features/home/data/datasource/remote.dart';
import 'package:designers_platform/features/home/data/repo/home_repo_imp.dart';
import 'package:designers_platform/features/home/domain/repo/home_repo.dart';
import 'package:designers_platform/features/home/domain/usecases/get_designers.dart';
import 'package:designers_platform/features/home/presentation/getx/home_controller.dart';
import 'package:designers_platform/features/order_management/data/datasource/order_remote.dart';
import 'package:designers_platform/features/order_management/data/repo/order_repo_imp.dart';
import 'package:designers_platform/features/order_management/domain/repo/order_repo.dart';
import 'package:designers_platform/features/order_management/domain/usecase/add_order.dart';
import 'package:designers_platform/features/order_management/domain/usecase/delete_order.dart';
import 'package:designers_platform/features/order_management/domain/usecase/get_orders.dart';
import 'package:designers_platform/features/order_management/domain/usecase/get_supervisor_phone_usecase.dart';
import 'package:designers_platform/features/order_management/domain/usecase/update_order.dart';
import 'package:designers_platform/features/order_management/presentation/getx/order_getx.dart';
import 'package:designers_platform/features/search/data/datasurce/search_remote.dart';
import 'package:designers_platform/features/search/data/repo/search_repo_imp.dart';
import 'package:designers_platform/features/search/domain/repo/search_repo.dart';
import 'package:designers_platform/features/search/domain/usecase/search_designers.dart';
import 'package:designers_platform/features/search/domain/usecase/search_designs.dart';
import 'package:designers_platform/features/search/presentation/getx/search_controller.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import 'core/data/network_info_impl.dart';
import 'core/domain/i_internet_info.dart';
import 'core/presentation/services/data_sync_service.dart';
import 'core/presentation/services/network_service.dart';
import 'features/auth/data/repositories/auth_repository_imp.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/order_management/data/datasource/chat_remote_datasource.dart';
import 'features/order_management/data/repo/chat_repo_impl.dart';
import 'features/order_management/domain/repo/i_chat_repository.dart';
import 'features/order_management/domain/usecase/chat_room/get_chat_messages_usecase.dart';
import 'features/order_management/domain/usecase/chat_room/send_message_useCase.dart';
import 'features/supervisor/data/datasources/supervisor_remote_datasource.dart';
import 'features/supervisor/data/repositories/supervisor_repository_impl.dart';
import 'features/supervisor/domain/repositories/supervisor_repository.dart';
import 'features/supervisor/domain/usecases/approve_order.dart';
import 'features/supervisor/domain/usecases/get_pending_orders.dart';
import 'features/supervisor/domain/usecases/update_supervisor_profile.dart';
import 'features/supervisor/presentation/getx/supervisor_controller.dart';

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
    // 4. (الخطوة الجديدة) ربط "منسق" البيانات
// هذا الكود "نشط" وسيبدأ الخدمة واللسنر فوراً عند تشغيل التطبيق
    Get.put(DataSyncService(), permanent: true);
    final uuid = Uuid();
    Get.lazyPut<Uuid>(fenix: true, () => uuid);

    /// SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(sharedPreferences, permanent: true);
    // ==========================================================================

    /// Supabase
    final dbS = Supabase.instance.client;
    Get.put<SupabaseClient>(dbS, permanent: true);

    /// Usecase
    Get.lazyPut<GetUserUseCase>(
        fenix: true, () => GetUserUseCase(Get.find<AuthRepository>()));
    Get.lazyPut<LogoutUsecase>(() => LogoutUsecase(Get.find<AuthRepository>()),
        fenix: true);

    ///========================== [ Feat: Auth ] ==============================
    /// Data Source
    Get.lazyPut<RemoteDataSource>(
        fenix: true, () => RemoteDataSource(Get.find<SupabaseClient>()));
    Get.lazyPut<LocalData>(
        fenix: true, () => LocalDataImp(Get.find<SharedPreferences>()));

    // ============================================================================

    /// Repository
    Get.lazyPut<AuthRepository>(
      fenix: true,
      () => AuthRepositoryImp(Get.find<INetworkInfo>(),
          Get.find<RemoteDataSource>(), Get.find<LocalData>()),
    );

    // ==========================================================================

    /// Use cases
    Get.lazyPut<LoginUsecase>(
        fenix: true, () => LoginUsecase(Get.find<AuthRepository>()));
    Get.lazyPut<SignUpUsecase>(
        fenix: true, () => SignUpUsecase(Get.find<AuthRepository>()));

    Get.lazyPut<DeleteAccountUsecase>(
        fenix: true, () => DeleteAccountUsecase(Get.find<AuthRepository>()));

    Get.lazyPut<GetUserUseCase>(
        fenix: true, () => GetUserUseCase(Get.find<AuthRepository>()));
    Get.lazyPut<ForgetPasswordUsecase>(
        fenix: true, () => ForgetPasswordUsecase(Get.find<AuthRepository>()));

    /// GetX
    Get.lazyPut<AuthController>(
        () => AuthController(
            Get.find<LoginUsecase>(),
            Get.find<SignUpUsecase>(),
            Get.find<DeleteAccountUsecase>(),
            Get.find<Uuid>(),
            Get.find<GetUserUseCase>(),
            Get.find<ForgetPasswordUsecase>()),
        fenix: true);

    ///========================== [ Feat: Client Profile ] ==============================
    /// Data Source
    Get.lazyPut<ClientRemoteDataSource>(
      fenix: true,
      () => ClientRemoteDataSourceImp(Get.find<SupabaseClient>()),
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
    Get.lazyPut(
      () => Get.find<SharedPreferences>(),
    );
    Get.lazyPut(
      fenix: true,
      () => DesignerLocalDataSourceImpBySharedPref(
        sharedPreferences: Get.find<SharedPreferences>(),
      ),
    );
    Get.lazyPut(
      fenix: true,
      () => DesignerRemoteDataSourceImpBySupabase(
        supabase: Get.find<SupabaseClient>(),
      ),
    );
    Get.lazyPut(
      () => ReviewLocalDataSourceImpBySql(
        sharedPreferences: Get.find<SharedPreferences>(),
      ),
    );
    Get.lazyPut(
      fenix: true,
      () => WorkLocalDataSourceImpBySql(
        sharedPreferences: Get.find<SharedPreferences>(),
      ),
    );

    /// Repo
    Get.lazyPut(
      fenix: true,
      () => DesignerRepoImp(
          Get.find<DesignerLocalDataSourceImpBySharedPref>(),
          Get.find<INetworkInfo>(),
          Get.find<DesignerRemoteDataSourceImpBySupabase>()),
    );
    Get.lazyPut(
      fenix: true,
      () => ReviewRepoImp(
        Get.find<ReviewLocalDataSourceImpBySql>(),
      ),
    );
    Get.lazyPut(
      fenix: true,
      () => WorkRepoImp(
        Get.find<WorkLocalDataSourceImpBySql>(),
      ),
    );

    /// UseCase
    Get.put<GetProfileUseCase>(
      permanent: true,
      GetProfileUseCase(
        designerRepository: Get.find<DesignerRepoImp>(),
      ),
    );
    Get.put<GetReviewUseCase>(
      permanent: true,
      GetReviewUseCase(
        reviewRepository: Get.find<ReviewRepoImp>(),
      ),
    );
    Get.put<GetWorkUseCase>(
      permanent: true,
      GetWorkUseCase(
        workRepository: Get.find<WorkRepoImp>(),
      ),
    );
    Get.lazyPut(
      fenix: true,
      () => UpdateProfileUseCase(
        designerRepository: Get.find<DesignerRepoImp>(),
      ),
    );
    Get.lazyPut(
      fenix: true,
      () => DeleteProfileUseCase(
        designerRepository: Get.find<DesignerRepoImp>(),
      ),
    );
    Get.lazyPut(
      fenix: true,
      () => AddReviewUseCase(
        reviewRepository: Get.find<ReviewRepoImp>(),
      ),
    );
    Get.lazyPut(
      fenix: true,
      () => UpdateReviewUseCase(
        reviewRepository: Get.find<ReviewRepoImp>(),
      ),
    );
    Get.lazyPut(
      fenix: true,
      () => DeleteReviewUseCase(
        reviewRepository: Get.find<ReviewRepoImp>(),
      ),
    );
    Get.lazyPut(
      fenix: true,
      () => AddWorkUseCase(
        workRepository: Get.find<WorkRepoImp>(),
      ),
    );
    Get.lazyPut(
      fenix: true,
      () => UpdateWorkUseCase(
        workRepository: Get.find<WorkRepoImp>(),
      ),
    );
    Get.lazyPut(
      fenix: true,
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
        Get.find<SharedPreferences>(),
        Get.find<SupabaseClient>(),
      ),
    );

    /// repo
    Get.lazyPut<OrderRepo>(
        fenix: true,
        () => OrderRepoImp(Get.find<OrderRemote>(), Get.find<INetworkInfo>()));

    /// Usecase
    Get.lazyPut<AddOrderUsecase>(
        fenix: true, () => AddOrderUsecase(Get.find<OrderRepo>()));
    Get.lazyPut<GetOrdersUsecase>(
        fenix: true, () => GetOrdersUsecase(Get.find<OrderRepo>()));
    Get.lazyPut<DeleteOrderUsecase>(
        fenix: true, () => DeleteOrderUsecase(Get.find<OrderRepo>()));
    Get.lazyPut<UpdateOrderUsecase>(
        fenix: true, () => UpdateOrderUsecase(Get.find<OrderRepo>()));
    Get.lazyPut<GetSupervisorPhoneUsecase>(
        fenix: true, () => GetSupervisorPhoneUsecase(Get.find<OrderRepo>()));

    /// Getx
    Get.lazyPut<OrderGetx>(
      fenix: true,
      () => OrderGetx(
        Get.find<GetOrdersUsecase>(),
        Get.find<DeleteOrderUsecase>(),
        Get.find<UpdateOrderUsecase>(),
        Get.find<GetSupervisorPhoneUsecase>(),
      ),
    );

    // --- Chat Feature ---
// DataSource
    Get.lazyPut<IChatRemoteDataSource>(
      fenix: true,
      () => ChatRemoteDataSourceImpl(
        Get.find<SupabaseClient>(),
      ),
    );

// Repository
    Get.lazyPut<IChatRepository>(
      fenix: true,
      () => ChatRepositoryImpl(
        Get.find<IChatRemoteDataSource>(),
      ),
    );

// UseCases
    Get.lazyPut(
      fenix: true,
      () => SendMessageUseCase(
        Get.find<IChatRepository>(),
      ),
    );
    Get.lazyPut(
      fenix: true,
      () => GetChatMessagesUseCase(
        Get.find<IChatRepository>(),
      ),
    );
// Get.lazyPut(() => SendMessageUseCase(Get.find()));

    /// =============================== [ Home ] ==================================
    /// datasource
    Get.lazyPut<Remote>(
        fenix: true, () => RemoteImp(Get.find<SupabaseClient>()));

    /// repo
    Get.lazyPut<HomeRepo>(
        fenix: true,
        () => HomeRepoImp(Get.find<INetworkInfo>(), Get.find<Remote>()));

    /// usecases
    Get.lazyPut<GetDesignersUsecase>(
        fenix: true, () => GetDesignersUsecase(Get.find<HomeRepo>()));

    /// getX
    Get.lazyPut<HomeController>(
        fenix: true, () => HomeController(Get.find<GetDesignersUsecase>()));

    /// ================================= [ Search ] =========================================
    /// datasource,
    Get.lazyPut<SearchRemote>(fenix: true, () => SearchRemoteImp());

    /// repo
    Get.lazyPut<SearchRepo>(
        fenix: true,
        () =>
            SearchRepoImp(Get.find<INetworkInfo>(), Get.find<SearchRemote>()));

    /// usecases
    Get.lazyPut<SearchDesignersUsecase>(
        fenix: true, () => SearchDesignersUsecase(Get.find<SearchRepo>()));
    Get.lazyPut<SearchDesignsUsecase>(
        fenix: true, () => SearchDesignsUsecase(Get.find<SearchRepo>()));

    ///getX
    Get.lazyPut<SearchControl>(
        fenix: true,
        () => SearchControl(Get.find<SearchDesignsUsecase>(),
            Get.find<SearchDesignersUsecase>()));

    ///========================== [ Feat: Supervisor ] ==============================
    /// Data Source
    Get.lazyPut<SupervisorRemoteDataSource>(
      fenix: true,
      () => SupervisorRemoteDataSourceImpl(Get.find<SupabaseClient>()),
    );

    /// Repository
    Get.lazyPut<SupervisorRepository>(
      fenix: true,
      () => SupervisorRepositoryImpl(Get.find<SupervisorRemoteDataSource>()),
    );

    /// Use Cases
    Get.lazyPut(
      fenix: true,
      () => GetPendingOrdersUseCase(Get.find<SupervisorRepository>()),
    );
    Get.lazyPut(
      fenix: true,
      () => ApproveOrderUseCase(Get.find<SupervisorRepository>()),
    );
    Get.lazyPut(
      fenix: true,
      () => UpdateSupervisorProfileUseCase(Get.find<SupervisorRepository>()),
    );

    /// GetX Controller
    Get.lazyPut<SupervisorController>(
      fenix: true,
      () => SupervisorController(
        Get.find<GetPendingOrdersUseCase>(),
        Get.find<ApproveOrderUseCase>(),
        Get.find<UpdateSupervisorProfileUseCase>(),
        Get.find<SaveUserUsecase>(),
      ),
    );
  }
}
