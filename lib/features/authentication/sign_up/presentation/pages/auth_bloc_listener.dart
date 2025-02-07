import 'package:flutter/material.dart';
import 'package:save_bite/features/authentication/sign_up/presentation/bloc/authentication_bloc.dart';
import '../../../verification/presentation/pages/verification.dart';

void handleAuthState(BuildContext context, AuthenticationState state) {
  if (state is ErrorAuthenticationState) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message.contains("already been taken") ? "Email or phone already in use" : state.message))
    );
  } else if (state is SignedUpSuccessState) {

    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => OTPVerificationScreen(otpToken: state.authEntity.otpToken, email: state.authEntity.email),
    ));
  }
}
