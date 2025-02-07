import 'package:equatable/equatable.dart';

class CheckCodeEntity extends Equatable {
  final String otp;
  final String otp_token;


  CheckCodeEntity({
   required this.otp,required this.otp_token});

  @override
  List<Object?> get props => [otp,otp_token];

}