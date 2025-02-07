import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:save_bite/features/authentication/sign_up/domain/entities/auth_entity.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/sign_up_entity.dart';
import '../../domain/repos/auth_repo.dart';
import '../datasorces/remote_data_source.dart';
import '../models/sign_up_model.dart';

typedef Future<Unit> SignUp();

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, AuthEntity>> signUp(SignUpEntity signUpEntity) async {
    try {
      final SignUpModel signUpModel = SignUpModel(
        userName: signUpEntity.userName,
        email: signUpEntity.email,
        password: signUpEntity.password,
        passwordConfirmation: signUpEntity.passwordConfirmation,
        answer: signUpEntity.answer,
        image: signUpEntity.image,
        type: signUpEntity.type,
        phone: signUpEntity.phone,
      );

      final authEntity = await authRemoteDataSource.signUp(signUpModel);
      return Right(authEntity);
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.errors)); // ✅ Now properly handled
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on OfflineException {
      return Left(OfflineFailure());
    } catch (e) {
      return Left(ServerFailure(message: "An unexpected error occurred."));
    }
  }
}
