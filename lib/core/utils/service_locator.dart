import 'package:get_it/get_it.dart';
import 'package:save_bite/features/authentication/login/data/data_source/login_remote_data_source.dart';
import 'package:save_bite/features/authentication/login/data/repo/login_repo_imp.dart';
import 'package:save_bite/features/authentication/login/domain/use_case/login_email_image_use_case.dart';
import 'package:save_bite/features/authentication/login/domain/use_case/login_email_password__use_case.dart';
import 'package:save_bite/features/authentication/lost_image/data/data_sources/lost_image_remote_data_source.dart';
import 'package:save_bite/features/authentication/lost_image/data/repos/lost_image_repo_imp.dart';
import 'package:save_bite/features/authentication/lost_image/domain/use_case/lost_image_use_case.dart';
import 'package:save_bite/features/authentication/lost_image/domain/use_case/lost_image_verfication_use_case.dart';

var getit = GetIt.instance;
void setupServiceLocator() {
  getit.registerSingleton<LoginEmailImageUseCase>(
    LoginEmailImageUseCase(
      loginRepo: LoginRepoImp(
        loginRemoteDataSource: LoginRemoteDataSourceImp(),
      ),
    ),
  );
  getit.registerSingleton<LoginEmailPasswordUseCase>(
    LoginEmailPasswordUseCase(
      loginRepo: LoginRepoImp(
        loginRemoteDataSource: LoginRemoteDataSourceImp(),
      ),
    ),
  );
  getit.registerSingleton<LostImageUseCase>(
    LostImageUseCase(
      lostImageRepo: LostImageRepoImp(
        lostImageRemoteDataSource: LostImageRemoteDataSourceImp(),
      ),
    ),
  );
  getit.registerSingleton<LostImageVerficationUseCase>(
    LostImageVerficationUseCase(
      lostImageRepo: LostImageRepoImp(
        lostImageRemoteDataSource: LostImageRemoteDataSourceImp(),
      ),
    ),
  );
}
