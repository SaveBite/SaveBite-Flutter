part of 'otp_bloc.dart';

abstract class OTPEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckCodeEvent extends OTPEvent {
  final CheckCodeEntity checkCodeEntity;
  CheckCodeEvent({required this.checkCodeEntity});
}

class ResendCodeEvent extends OTPEvent {
  final ResendCodeEntity resendCodeEntity;

  ResendCodeEvent({required this.resendCodeEntity});
}
