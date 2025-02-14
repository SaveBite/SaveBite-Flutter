import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/manger/lost_image_cubit/lost_image_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'email:${BlocProvider.of<LostImageCubit>(context).message}',
        ),
      ),
    );
  }
}
