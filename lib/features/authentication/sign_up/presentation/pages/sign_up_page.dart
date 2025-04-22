import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/features/authentication/sign_up/presentation/bloc/authentication_bloc.dart';
import 'package:save_bite/features/authentication/sign_up/presentation/pages/sign_up_form.dart';
import '../../../../../core/widgets/loading_widget.dart';
import 'auth_bloc_listener.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            handleAuthState(context, state);
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return LoadingWidget();
            } else {
              return SignUpForm();
            }
          },
        ),
      ),
    );
  }
}
