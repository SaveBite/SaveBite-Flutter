import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_active_buttom.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_in_active_buttom.dart';
import 'package:save_bite/features/authentication/login/presentation/views/widgets/custom_message_widget.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/manger/lost_image_cubit/lost_image_cubit.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/views/lost_mage_verification_view.dart';

class LostImageButtomBlocBuilder extends StatelessWidget {
  const LostImageButtomBlocBuilder({
    super.key,
    required this.myKey,
  });

  final GlobalKey<FormState> myKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LostImageCubit, LostImageState>(
      listener: (context, state) {
        if (state is LostImageSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LostImageVerificationView(),
            ),
          );
        } else if (state is LostImageFailure) {
          showOverlayWidget(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        if (state is LostImageButtomActiveState) {
          return CustomActiveButtom(
            onTap: () async {
              if (myKey.currentState!.validate()) {
                await BlocProvider.of<LostImageCubit>(context).lostmImage();
              }
            },
            content: 'Send',
            icon: false,
          );
        } else {
          return CustomInActiveButtom(
            onTap: () async {
              if (myKey.currentState!.validate()) {
                await BlocProvider.of<LostImageCubit>(context).lostmImage();
              }
            },
            content: 'Send',
            icon: false,
          );
        }
      },
    );
  }
}
