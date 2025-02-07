import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:save_bite/features/authentication/sign_up/domain/entities/auth_entity.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/local_data_source.dart';
import '../../domain/entities/sign_up_entity.dart';
import '../../domain/usecases/sign_up_use_case.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignUpUseCase signUpUseCase;

  AuthenticationBloc({
    required this.signUpUseCase,
  }) : super(AuthInitial()) {
    on<SignUpEvent>(_onSignUpEvent);
  }


  /// 🛠 Handles user sign-up and saves token
  Future<void> _onSignUpEvent(SignUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoadingState());

    final failureOrSuccess = await signUpUseCase(event.signUpEntity);

    if (emit.isDone) return;

    await failureOrSuccess.fold(
          (failure) async {
        print("🔥 Sign-Up Error: ${failure.toString()}");

        if (!emit.isDone) {
          if (failure is ValidationFailure) {
            emit(ErrorAuthenticationState(message: failure.message)); // ✅ Displays API errors
          } else {
            emit(ErrorAuthenticationState(message: failure.message));
          }
        }
      },
          (success) async {
        print("✅ Sign-Up Successful: ${success.toString()}");

        if (!emit.isDone) {
          emit(SignedUpSuccessState(authEntity: success));
        }
      },
    );


  }

}
