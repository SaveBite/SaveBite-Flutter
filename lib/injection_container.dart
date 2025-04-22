import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:save_bite/core/network/local_data_source.dart';
import 'package:save_bite/core/network/network_info.dart';

// Authentication Imports
import 'package:save_bite/features/authentication/sign_up/data/datasorces/remote_data_source.dart';
import 'package:save_bite/features/authentication/sign_up/data/repos/auth_repo_impl.dart';
import 'package:save_bite/features/authentication/sign_up/domain/repos/auth_repo.dart';
import 'package:save_bite/features/authentication/sign_up/domain/usecases/sign_up_use_case.dart';
import 'package:save_bite/features/authentication/sign_up/presentation/bloc/authentication_bloc.dart';

// Login Imports
import 'package:save_bite/features/authentication/login/data/data_source/login_remote_data_source.dart';
import 'package:save_bite/features/authentication/login/data/repo/login_repo_imp.dart';
import 'package:save_bite/features/authentication/login/domain/repo/login_repo.dart';
import 'package:save_bite/features/authentication/login/domain/use_case/login_email_password__use_case.dart';
import 'package:save_bite/features/authentication/login/domain/use_case/login_email_image_use_case.dart';

// Verification Imports
import 'package:save_bite/features/authentication/verification/data/datasources/remote_data_source.dart';
import 'package:save_bite/features/authentication/verification/data/repos/otp_repo_impl.dart';
import 'package:save_bite/features/authentication/verification/domain/repo/verification_repo.dart';
import 'package:save_bite/features/authentication/verification/domain/usecases/check_code_use_case.dart';
import 'package:save_bite/features/authentication/verification/domain/usecases/resend_otp.dart';
import 'package:save_bite/features/authentication/verification/presentation/bloc/otp_bloc.dart';

// Lost Image Imports
import 'package:save_bite/features/authentication/lost_image/data/data_sources/lost_image_remote_data_source.dart';
import 'package:save_bite/features/authentication/lost_image/data/repos/lost_image_repo_imp.dart';
import 'package:save_bite/features/authentication/lost_image/domain/use_case/lost_image_use_case.dart';
import 'package:save_bite/features/authentication/lost_image/domain/use_case/lost_image_verfication_use_case.dart';

// Stock Feature Imports
import 'features/home/stock/data/datasorces/stock_remote_data_source.dart';
import 'features/home/stock/data/repos/stock_repo_impl.dart';
import 'features/home/stock/domain/repos/stock_repo.dart';
import 'features/home/stock/domain/usecases/stock_usecase.dart';
import 'features/home/stock/presentation/bloc/stock_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  try {
    print('🔄 Initializing dependencies...');

    await _initCore();
    _initAuthentication();
    _initVerification();
    _initLostImage();
    _initStockFeature();

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

  // ✅ Register LoginRepo using the interface
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

  sl.registerLazySingleton<RemoteDataSource>(() =>
      RemoteDataSourceImpl(client: sl(), authDataSource: sl()));

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

  sl.registerLazySingleton<LostImageRepoImp>(
          () => LostImageRepoImp(lostImageRemoteDataSource: sl()));

  sl.registerLazySingleton(() => LostImageUseCase(lostImageRepo: sl()));
  sl.registerLazySingleton(() => LostImageVerficationUseCase(lostImageRepo: sl()));
}

// ==========================
// 🔹 Stock Feature
// ==========================
void _initStockFeature() {
  print('📦 Initializing Stock Feature...');

  sl.registerLazySingleton<StockRemoteDataSource>(
          () => StockRemoteDataSourceImp(dio: Dio()));

  sl.registerLazySingleton<StockRepo>(() =>
      StockRepoImp(stockRemoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton(() => StockUseCase(stockRepo: sl()));
  sl.registerFactory(() => StockBloc(stockUseCase: sl()));
}
