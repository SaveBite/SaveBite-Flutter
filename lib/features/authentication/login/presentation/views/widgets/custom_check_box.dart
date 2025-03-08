import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/features/authentication/login/presentation/manger/login_cubit/login_cubit.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            if (_isChecked) {
              _isChecked = false;
              BlocProvider.of<LoginCubit>(context).rememberMe = false;
            } else {
              _isChecked = true;
              BlocProvider.of<LoginCubit>(context).rememberMe = true;
            }
          },
        );
      },
      child: SizedBox(
        // Use SizedBox to set fixed size
        width: 20,
        height: 20,
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(4), // Smaller radius for smaller size
            border: Border.all(
              color: _isChecked ? Color(0xff5EDA42) : Colors.grey,
              width: 1, // Thinner border for smaller size
            ),
            color: _isChecked ? Color(0xff5EDA42) : Colors.transparent,
          ),
          child: Center(
            child: _isChecked
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14, // Smaller icon size
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
