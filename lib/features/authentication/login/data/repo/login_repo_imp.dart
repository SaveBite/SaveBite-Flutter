import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:save_bite/core/failure/failure.dart';
import 'package:save_bite/features/authentication/login/data/data_source/login_remote_data_source.dart';
import 'package:save_bite/features/authentication/login/data/model/user_model.dart';
import 'package:save_bite/features/authentication/login/domain/repo/login_repo.dart';

class LoginRepoImp extends LoginRepo {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepoImp({required this.loginRemoteDataSource});
  @override
  Future<Either<Failure, UserModel>> loginEmailImage({
    required String email,
    required File image,
  }) async {
    try {
      UserModel userModel = await loginRemoteDataSource.loginEmailImage(
        email: email,
        image: image,
      );
      return right(userModel);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioException(e),
        );
      } else {
        return left(
          ServerFailure(
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failure, UserModel>> loginEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserModel userModel = await loginRemoteDataSource.loginEmailPassword(
        email: email,
        password: password,
      );
      return right(userModel);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioException(e),
        );
      } else {
        return left(
          ServerFailure(
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }
}
