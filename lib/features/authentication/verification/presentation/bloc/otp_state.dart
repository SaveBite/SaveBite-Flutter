part of 'otp_bloc.dart';

abstract class OTPState extends Equatable {
  @override
  List<Object> get props => [];
}

class OTPInitial extends OTPState {}

class LoadingOTPState extends OTPState {}

class CheckCodeSuccessState extends OTPState {
  final CheckCodeResponseEntity checkCodeResponseEntity;

  CheckCodeSuccessState({required this.checkCodeResponseEntity});

  @override
  List<Object> get props => [checkCodeResponseEntity];
}

class ResendOtpSuccess extends OTPState {
  final ResendCodeResponseEntity resendCodeResponseEntity;

  ResendOtpSuccess({required this.resendCodeResponseEntity});

  @override
  List<Object> get props => [resendCodeResponseEntity];
}

class ErrorOTPState extends OTPState {
  final String message;

  ErrorOTPState({required this.message});

  @override
  List<Object> get props => [message];
}
