import 'package:equatable/equatable.dart';

class ResendCodeEntity extends Equatable{
  final String email;

  const ResendCodeEntity({
    required this.email,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [email];
}