part of 'lost_image_cubit.dart';

@immutable
sealed class LostImageState {}

final class LostImageInitial extends LostImageState {}

final class LostImageLoading extends LostImageState {}

final class LostImageSuccess extends LostImageState {}

final class LostImageFailure extends LostImageState {
  final String errorMessage;

  LostImageFailure({required this.errorMessage});
}

final class LostImageVerificationLoading extends LostImageState {}

final class LostImageVerificationSuccess extends LostImageState {}

final class LostImageVerificationFailure extends LostImageState {
  final String errorMessage;

  LostImageVerificationFailure({required this.errorMessage});
}

final class LostImageButtomActiveState extends LostImageState {}

final class LostImageButtomInActiveState extends LostImageState {}

final class LostImageVerificationButtomActiveState extends LostImageState {}

final class LostImageVerificationButtomInActiveState extends LostImageState {}
