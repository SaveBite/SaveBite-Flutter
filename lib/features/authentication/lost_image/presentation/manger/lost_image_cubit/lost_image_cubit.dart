import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:save_bite/features/authentication/lost_image/domain/use_case/lost_image_use_case.dart';
import 'package:save_bite/features/authentication/lost_image/domain/use_case/lost_image_verfication_use_case.dart';

part 'lost_image_state.dart';

class LostImageCubit extends Cubit<LostImageState> {
  String? val1, val2, val3, val4;
  String? otp;
  String? otpToken, email, answer;
  String? message;
  LostImageCubit(
      {required this.lostImgeUseCase,
      required this.lostImageVerficationUseCase})
      : super(LostImageInitial());
  final LostImageUseCase lostImgeUseCase;
  final LostImageVerficationUseCase lostImageVerficationUseCase;

  Future<void> lostmImage() async {
    emit(LostImageLoading());
    var result = await lostImgeUseCase.call(email: email!, answer: answer!);
    result.fold(
      (failure) {
        emit(
          LostImageFailure(errorMessage: failure.errorMessage),
        );
      },
      (success) {
        otpToken = success;
        emit(
          LostImageSuccess(),
        );
      },
    );
  }

  Future<void> lostImageVerfication() async {
    otp = (val1 ?? "") + (val2 ?? "") + (val3 ?? "") + (val4 ?? "");

    emit(LostImageLoading());
    var result = await lostImageVerficationUseCase.call(
        email: email!, otp: otp!, otpToken: otpToken!);
    result.fold(
      (failure) {
        emit(
          LostImageVerificationFailure(errorMessage: failure.errorMessage),
        );
      },
      (success) {
        message = success;
        emit(
          LostImageVerificationSuccess(),
        );
      },
    );
  }

  changeLostImageButtomColor() {
    if (email != null && answer != null) {
      emit(LostImageButtomActiveState());
    } else {
      emit(LostImageButtomInActiveState());
    }
  }

  changeLostImageVerificationButtomColor() {
    if (val1 != null && val2 != null && val3 != null && val4 != null) {
      emit(LostImageVerificationButtomActiveState());
    } else {
      emit(LostImageVerificationButtomInActiveState());
    }
  }
}
