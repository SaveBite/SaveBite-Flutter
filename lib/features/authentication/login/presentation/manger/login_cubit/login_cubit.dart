import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:save_bite/constants.dart';
import 'package:save_bite/features/authentication/login/data/model/save_user_data.dart';
import 'package:save_bite/features/authentication/login/data/model/user_model.dart';
import 'package:save_bite/features/authentication/login/domain/use_case/login_email_image_use_case.dart';
import 'package:save_bite/features/authentication/login/domain/use_case/login_email_password__use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
      {required this.loginEmailImageUseCase,
      required this.loginEmailPasswordUseCase})
      : super(LoginInitial());
  UserModel? userModel;
  String? email;
  String? password;
  File? image;
  bool? rememberMe;
  final LoginEmailImageUseCase loginEmailImageUseCase;
  final LoginEmailPasswordUseCase loginEmailPasswordUseCase;

  Future<void> loginEmailPassword() async {
    emit(LoginLoading());
    var result = await loginEmailPasswordUseCase.call(
        email: email!, password: password!);
    result.fold((failure) {
      emit(LoginFailure(
        errorMessage: failure.errorMessage,
      ));
    }, (successValue) async {
      userModel = successValue;
      await saveUserAndRememberMe();
      emit(LoginSuccess());
    });
  }

  Future<void> loginEmailiImage() async {
    emit(LoginLoading());
    var result =
        await loginEmailImageUseCase.call(email: email!, image: image!);
    result.fold((failure) {
      emit(LoginFailure(
        errorMessage: failure.errorMessage,
      ));
    }, (successValue) async {
      userModel = successValue;
      await saveUserAndRememberMe();
      emit(LoginSuccess());
    });
  }

  void chaneButtomColor() {
    if ((email != null && image != null) ||
        (email != null && password != null)) {
      emit(ButtomActive());
    } else {
      emit(ButtomInActive());
    }
  }

  Future<void> saveUserAndRememberMe() async {
    SaveUserData.user = userModel;
    var userBox = Hive.box<UserModel?>(kUserBox);
    var remmberBox = Hive.box<bool?>(kRemmberBox);

    if (rememberMe != null) {
      await remmberBox.put('rememberMe', rememberMe);
      SaveUserData.rememberMe = rememberMe;
      await userBox.put('user', userModel);
    } else {
      await remmberBox.put('rememberMe', false);
      SaveUserData.rememberMe = false;
    }
  }

  Future<void> getUserAndRememberMe() async {
    var userBox = Hive.box<UserModel?>(kUserBox);
    var remmberBox = Hive.box<bool?>(kRemmberBox);

    rememberMe = remmberBox.get('rememberMe') ?? false;
    SaveUserData.rememberMe = remmberBox.get('rememberMe') ?? false;

    userModel = userBox.get('user');
    SaveUserData.user = userBox.get('user');
  }
}
