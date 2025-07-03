import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:save_bite/features/authentication/lost_image/domain/repo/lost_image_repo.dart';
import 'package:save_bite/features/tracking/display_tracking_data/data/data_source/tracking_remote_data_source.dart';
import 'package:save_bite/features/tracking/display_tracking_data/data/repo/tracking_repo_imp.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/use_case/delete_tracking_product_use_case.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/use_case/get_tracking_products_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Core
import 'package:save_bite/core/network/local_data_source.dart';
import 'package:save_bite/core/network/network_info.dart';

// Authentication - Sign Up
import 'package:save_bite/features/authentication/sign_up/data/datasorces/remote_data_source.dart';
import 'package:save_bite/features/authentication/sign_up/data/repos/auth_repo_impl.dart';
import 'package:save_bite/features/authentication/sign_up/domain/repos/auth_repo.dart';
import 'package:save_bite/features/authentication/sign_up/domain/usecases/sign_up_use_case.dart';
import 'package:save_bite/features/authentication/sign_up/presentation/bloc/authentication_bloc.dart';

// Authentication - Login
import 'package:save_bite/features/authentication/login/data/data_source/login_remote_data_source.dart';
import 'package:save_bite/features/authentication/login/data/repo/login_repo_imp.dart';
import 'package:save_bite/features/authentication/login/domain/repo/login_repo.dart';
import 'package:save_bite/features/authentication/login/domain/use_case/login_email_password__use_case.dart';
import 'package:save_bite/features/authentication/login/domain/use_case/login_email_image_use_case.dart';

// Verification
import 'package:save_bite/features/authentication/verification/data/datasources/remote_data_source.dart';
import 'package:save_bite/features/authentication/verification/data/repos/otp_repo_impl.dart';
import 'package:save_bite/features/authentication/verification/domain/repo/verification_repo.dart';
import 'package:save_bite/features/authentication/verification/domain/usecases/check_code_use_case.dart';
import 'package:save_bite/features/authentication/verification/domain/usecases/resend_otp.dart';
import 'package:save_bite/features/authentication/verification/presentation/bloc/otp_bloc.dart';

// Lost Image
import 'package:save_bite/features/authentication/lost_image/data/data_sources/lost_image_remote_data_source.dart';
import 'package:save_bite/features/authentication/lost_image/data/repos/lost_image_repo_imp.dart';
import 'package:save_bite/features/authentication/lost_image/domain/use_case/lost_image_use_case.dart';
import 'package:save_bite/features/authentication/lost_image/domain/use_case/lost_image_verfication_use_case.dart';

// Home Feature
import 'package:save_bite/features/home/data/date_sources/home_remote_data_sources.dart';
import 'package:save_bite/features/home/data/repos/home_repo_imp.dart';
import 'package:save_bite/features/home/domain/use_cases/add_product_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/get_product_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/get_stock_data_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/upload_products_use_case.dart';

// Stock Feature
import 'features/ChatBot/data/repos/chat_repos_impl.dart';
import 'features/ChatBot/domain/usecases/get_chat_messages.dart';
import 'features/ChatBot/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'features/ChatBot/presentation/bloc/favorite_messages_bloc/favorite_messages_bloc.dart';
import 'features/stock/data/datasorces/stock_remote_data_source.dart';
import 'features/stock/data/repos/stock_repo_impl.dart';
import 'features/stock/domain/repos/stock_repo.dart';
import 'features/stock/domain/usecases/stock_usecase.dart';
import 'features/stock/presentation/bloc/stock_bloc.dart';

// Anyltics Feature
import 'package:save_bite/features/analytics/data/data_sources/anayltics_remote_data_sources.dart';
import 'package:save_bite/features/analytics/data/repos/anayltics_repo_imp.dart';
import 'package:save_bite/features/analytics/domain/use_case/fetch_anyltics_details_use_case.dart';
import 'package:save_bite/features/analytics/domain/use_case/get_sales_data_use_case.dart';

// Chatbot Feature
import 'features/ChatBot/data/datasources/chat_remote_data_source.dart';
import 'features/ChatBot/data/datasources/recipe_remote_data_source.dart';
import 'features/ChatBot/data/repos/recipe_repository_impl.dart';
import 'features/ChatBot/domain/repo/chat_repository.dart';
import 'features/ChatBot/domain/repo/recipe_repository.dart';
import 'features/ChatBot/domain/usecases/get_favorite_messages.dart';
import 'features/ChatBot/domain/usecases/get_recipe.dart';
import 'features/ChatBot/domain/usecases/send_message.dart';
import 'features/ChatBot/domain/usecases/toggle_favorite.dart';
import 'features/ChatBot/presentation/bloc/recipe_bloc/recipe_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  try {
    print('🔄 Initializing dependencies...');

    await _initCore();
    _initAuthentication();
    _initVerification();
    _initLostImage();
    _initStockFeature();
    _initChatbotFeature();

    print('✅ All dependencies registered successfully!');
  } catch (e, stackTrace) {
    print('🚨 Error during initialization: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
}

// =====================
// 🔹 Core Dependencies
// =====================
Future<void> _initCore() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: sl()));
}

// ==========================
// 🔹 Authentication Feature
// ==========================
void _initAuthentication() {
  print('📦 Initializing Authentication...');

  // ✅ Sign Up
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: sl()));
  sl.registerLazySingleton(() => SignUpUseCase(authRepository: sl()));
  sl.registerFactory(() => AuthenticationBloc(signUpUseCase: sl()));

  // ✅ Login
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImp());
  sl.registerLazySingleton<LoginRepo>(
      () => LoginRepoImp(loginRemoteDataSource: sl()));
  sl.registerLazySingleton(() => LoginEmailImageUseCase(loginRepo: sl()));
  sl.registerLazySingleton(() => LoginEmailPasswordUseCase(loginRepo: sl()));
}

// ==========================
// 🔹 Verification Feature
// ==========================
void _initVerification() {
  print('📦 Initializing Verification...');

  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl(), authDataSource: sl()));
  sl.registerLazySingleton<VerificationRepo>(() => OtpRepoImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
        localDataSource: sl(),
      ));
  sl.registerLazySingleton(() => CheckCodeUseCase(verificationRepo: sl()));
  sl.registerLazySingleton(() => ResendCodeUseCase(verificationRepo: sl()));
  sl.registerFactory(() => OTPBloc(
        checkCodeUseCase: sl(),
        resendCodeUseCase: sl(),
      ));
}

// ==========================
// 🔹 Lost Image Feature
// ==========================
void _initLostImage() {
  print('📦 Initializing Lost Image...');

  sl.registerLazySingleton<LostImageRemoteDataSource>(
      () => LostImageRemoteDataSourceImp());
  sl.registerLazySingleton<LostImageRepo>(
      () => LostImageRepoImp(lostImageRemoteDataSource: sl()));
  sl.registerLazySingleton(() => LostImageUseCase(lostImageRepo: sl()));
  sl.registerLazySingleton(
      () => LostImageVerficationUseCase(lostImageRepo: sl()));
}

// ==========================
// 🔹 Stock Feature
// ==========================
void _initStockFeature() {
  print('📦 Initializing Stock Feature...');

  sl.registerLazySingleton<StockRemoteDataSource>(
      () => StockRemoteDataSourceImp(dio: Dio()));
  sl.registerLazySingleton<StockRepo>(
      () => StockRepoImp(stockRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton(() => StockUseCase(stockRepo: sl()));
  sl.registerFactory(() => StockBloc(stockUseCase: sl()));

  // ✅ Home UseCases
  final homeRemote = HomeRemoteDataSourcesImp(dio: Dio());
  final homeRepo = HomeRepoImp(homeRemoteDataSources: homeRemote);
  sl.registerSingleton(GetProductUseCase(homeRepo: homeRepo));
  sl.registerSingleton(GetStockDataUseCase(homeRepo: homeRepo));
  sl.registerSingleton(UploadProductsUseCase(homeRepo: homeRepo));
  sl.registerSingleton(AddProductUseCase(homeRepo: homeRepo));

  //✅ Anyltics UseCase
  final anylticsRemote = AnaylticsRemoteDataSourcesImp(dio: Dio());
  final anaylticsRepo =
      AnaylticsRepoImp(anaylticsRemoteDataSources: anylticsRemote);
  sl.registerSingleton<FetchAnylticsDetailsUseCase>(
      FetchAnylticsDetailsUseCase(anaylticsRepo: anaylticsRepo));
  sl.registerSingleton<GetSalesDataUseCase>(
      GetSalesDataUseCase(anaylticsRepo: anaylticsRepo));
}

// ==========================
// 🔹 Chatbot Feature
// ==========================
void _initChatbotFeature() {
  print('📦 Initializing Chatbot Feature...');

  // Recipe
  sl.registerLazySingleton<RecipeRemoteDataSource>(
      () => RecipeRemoteDataSource());
  sl.registerLazySingleton<RecipeRepository>(() => RecipeRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton(() => GetRecipe(sl()));
  sl.registerFactory(() => RecipeBloc(sl()));

  // Chat
  sl.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton(() => SendMessage(sl()));
  sl.registerLazySingleton(() => ToggleFavorite(sl()));
  sl.registerLazySingleton(() => GetFavoriteMessages(sl()));
  sl.registerLazySingleton(() => GetChatMessages(sl()));
  sl.registerFactory(() => ChatBloc(sl(), sl()));
  sl.registerFactory(() => FavoriteMessagesBloc(sl()));

  //✅ Tracking UseCase
  final trackingRemote = TrackingRemoteDataSourceImp();
  final trackingRepo =
      TrackingRepoImp(trackingRemoteDataSource: trackingRemote);
  sl.registerSingleton<GetTrackingProductsUseCase>(
      GetTrackingProductsUseCase(trackingRepo: trackingRepo));
  sl.registerSingleton<DeleteTrackingProductUseCase>(
      DeleteTrackingProductUseCase(repo: trackingRepo));
}
