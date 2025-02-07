import 'package:equatable/equatable.dart';

class ResendCodeResponseEntity extends Equatable {
  final String otpToken;

  const ResendCodeResponseEntity({required this.otpToken});

  @override
  List<Object?> get props => [otpToken];
}
