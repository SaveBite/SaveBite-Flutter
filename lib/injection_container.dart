import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:save_bite/features/authentication/login/domain/use_case/login_email_password__use_case.dart';
import 'package:save_bite/features/authentication/lost_image/data/data_sources/lost_image_remote_data_source.dart';
import 'package:save_bite/features/authentication/lost_image/data/repos/lost_image_repo_imp.dart';
import 'package:save_bite/features/authentication/lost_image/domain/use_case/lost_image_use_case.dart';
import 'package:save_bite/features/home/data/date_sources/home_remote_data_sources.dart';
import 'package:save_bite/features/home/data/repos/home_repo_imp.dart';
import 'package:save_bite/features/home/domain/use_cases/add_product_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/get_product_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/get_stock_data_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/upload_products_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:save_bite/core/network/local_data_source.dart';
import 'package:save_bite/core/network/network_info.dart';
import 'package:save_bite/features/authentication/sign_up/data/datasorces/remote_data_source.dart';
import 'package:save_bite/features/authentication/sign_up/data/repos/auth_repo_impl.dart';
import 'package:save_bite/features/authentication/sign_up/domain/repos/auth_repo.dart';
import 'package:save_bite/features/authentication/sign_up/domain/usecases/sign_up_use_case.dart';
import 'package:save_bite/features/authentication/sign_up/presentation/bloc/authentication_bloc.dart';
import 'package:save_bite/features/authentication/verification/data/datasources/remote_data_source.dart';
import 'package:save_bite/features/authentication/verification/data/repos/otp_repo_impl.dart';
import 'package:save_bite/features/authentication/verification/domain/repo/verification_repo.dart';
import 'package:save_bite/features/authentication/verification/domain/usecases/check_code_use_case.dart';
import 'package:save_bite/features/authentication/verification/domain/usecases/resend_otp.dart';
import 'package:save_bite/features/authentication/verification/presentation/bloc/otp_bloc.dart';
import 'package:save_bite/features/authentication/login/data/data_source/login_remote_data_source.dart';
import 'package:save_bite/features/authentication/login/data/repo/login_repo_imp.dart';
import 'package:save_bite/features/authentication/login/domain/use_case/login_email_image_use_case.dart';
import 'package:save_bite/features/authentication/lost_image/domain/use_case/lost_image_verfication_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  try {
    print('🔄 Starting dependency initialization...');

    //! External Dependencies
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => http.Client());
    sl.registerLazySingleton(() => InternetConnectionChecker());
    //! Core Dependencies
    sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(connectionChecker: sl()));

    sl.registerLazySingleton<LocalDataSource>(
        () => LocalDataSourceImpl(sharedPreferences: sl()));

    //! 1- Authentication Feature :

    print('📦 Initializing Authentication feature...');

    //✅ LoginEmailImageUseCase
    sl.registerSingleton<LoginEmailImageUseCase>(
      LoginEmailImageUseCase(
        loginRepo: LoginRepoImp(
          loginRemoteDataSource: LoginRemoteDataSourceImp(),
        ),
      ),
    );
    //✅ LoginEmailPasswordUseCase
    sl.registerSingleton<LoginEmailPasswordUseCase>(
      LoginEmailPasswordUseCase(
        loginRepo: LoginRepoImp(
          loginRemoteDataSource: LoginRemoteDataSourceImp(),
        ),
      ),
    );
    //✅ LostImageUseCase
    sl.registerSingleton<LostImageUseCase>(
      LostImageUseCase(
        lostImageRepo: LostImageRepoImp(
          lostImageRemoteDataSource: LostImageRemoteDataSourceImp(),
        ),
      ),
    );
    //✅ LostImageVerficationUseCase
    sl.registerSingleton<LostImageVerficationUseCase>(
      LostImageVerficationUseCase(
        lostImageRepo: LostImageRepoImp(
          lostImageRemoteDataSource: LostImageRemoteDataSourceImp(),
        ),
      ),
    );

    // ✅ Register AuthRemoteDataSource first
    sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(client: sl()));

    // ✅ Register Use Cases
    sl.registerLazySingleton(() => SignUpUseCase(authRepository: sl()));

    // ✅ Register Bloc
    sl.registerFactory(() => AuthenticationBloc(signUpUseCase: sl()));

    // ✅ Register Repos
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: sl()),
    );

    //! Verification Feature
    print('📦 Initializing Verification feature...');

    // ✅ Register Verification Remote Data Source
    sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(
        client: sl(), authDataSource: sl())); // ✅ Added authDataSource

    // ✅ Register Verification Repository
    sl.registerLazySingleton<VerificationRepo>(() => OtpRepoImpl(
          networkInfo: sl(),
          remoteDataSource: sl(),
          localDataSource: sl(),
        ));

    // ✅ Register Use Cases
    sl.registerLazySingleton(() => CheckCodeUseCase(verificationRepo: sl()));
    sl.registerLazySingleton(() => ResendCodeUseCase(verificationRepo: sl()));

    // ✅ Register OTP Bloc
    sl.registerFactory(() => OTPBloc(
          checkCodeUseCase: sl(),
          resendCodeUseCase: sl(),
        ));

    //! 2- Home Feature :

    //✅ Home Repo

    //✅ GetProductsUseCase
    sl.registerSingleton<GetProductUseCase>(
      GetProductUseCase(
        homeRepo: HomeRepoImp(
          homeRemoteDataSources: HomeRemoteDataSourcesImp(
            dio: Dio(),
          ),
        ),
      ),
    );
    //✅ GetStockDataUseCase
    sl.registerSingleton<GetStockDataUseCase>(
      GetStockDataUseCase(
        homeRepo: HomeRepoImp(
          homeRemoteDataSources: HomeRemoteDataSourcesImp(
            dio: Dio(),
          ),
        ),
      ),
    );
    //✅ UploadProductsUseCase
    sl.registerSingleton<UploadProductsUseCase>(
      UploadProductsUseCase(
        homeRepo: HomeRepoImp(
          homeRemoteDataSources: HomeRemoteDataSourcesImp(
            dio: Dio(),
          ),
        ),
      ),
    );
    //✅ AddProductsUseCase
    sl.registerSingleton<AddProductUseCase>(
      AddProductUseCase(
        homeRepo: HomeRepoImp(
          homeRemoteDataSources: HomeRemoteDataSourcesImp(
            dio: Dio(),
          ),
        ),
      ),
    );
  } catch (e, stackTrace) {
    print('🚨 Error during dependency initialization: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
}
