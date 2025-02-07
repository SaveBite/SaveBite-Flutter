import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:save_bite/features/authentication/verification/domain/entity/check_code_entity.dart';
import 'package:save_bite/features/authentication/verification/domain/entity/check_code_response_entity.dart';
import 'package:save_bite/features/authentication/verification/domain/entity/resend_code_entity.dart';
import 'package:save_bite/features/authentication/verification/domain/usecases/check_code_use_case.dart';
import 'package:save_bite/features/authentication/verification/domain/usecases/resend_otp.dart';
import '../../../../../core/network/local_data_source.dart';
import '../../domain/entity/resend_code response_entity.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OTPBloc extends Bloc<OTPEvent, OTPState> {
  final CheckCodeUseCase checkCodeUseCase;
  final ResendCodeUseCase resendCodeUseCase;

  OTPBloc({
    required this.checkCodeUseCase,
    required this.resendCodeUseCase,
  }) : super(OTPInitial()) {
    on<CheckCodeEvent>(_onCheckCodeEvent);
    on<ResendCodeEvent>(_onResendCodeEvent);
  }

  Future<void> _onCheckCodeEvent(CheckCodeEvent event, Emitter<OTPState> emit) async {
    emit(LoadingOTPState());
    print("\ud83d\udce4 OTP Verification Request Sent: \${event.checkCodeEntity}");

    final failureOrSuccess = await checkCodeUseCase(event.checkCodeEntity);

    failureOrSuccess.fold(
          (failure) {
        print("\u274c OTP Verification Failed: \${failure.toString()}");
        emit(ErrorOTPState(message: failure.toString()));
      },
          (success) async {
        print("\u2705 OTP Verification Success: \${success.toString()}");
        if (success.token != null && success.token!.isNotEmpty) {
          print("\u2705 New Auth Token Saved: \${success.token}");
        } else {
          print("\u26a0\ufe0f Warning: No token received after OTP verification.");
        }
        emit(CheckCodeSuccessState(checkCodeResponseEntity: success));
      },
    );
  }

  Future<void> _onResendCodeEvent(ResendCodeEvent event, Emitter<OTPState> emit) async {
    emit(LoadingOTPState());
    print("\ud83d\udce4 Resending OTP for Email: \${event.resendCodeEntity.email}");

    final failureOrSuccess = await resendCodeUseCase(event.resendCodeEntity);

    failureOrSuccess.fold(
          (failure) {
        print("\u274c Resend OTP Failed: \${failure.toString()}");
        emit(ErrorOTPState(message: failure.toString()));
      },
          (success) {
        print("\u2705 OTP Resend Success: \${success.toString()}");
        emit(ResendOtpSuccess(resendCodeResponseEntity: success));
      },
    );
  }
}
