import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:save_bite/features/authentication/sign_up/presentation/bloc/authentication_bloc.dart';
import 'package:save_bite/core/widgets/custom_elevated_button.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../domain/entities/sign_up_entity.dart';
import '../widgets/custom_drop_down_list.dart';
import '../widgets/custom_text_feild.dart';
import '../widgets/file_upload_container.dart';
import '../widgets/international_phone_number.dart';
import '../widgets/show_welcome_message.dart';
import 'package:save_bite/core/utils/validators.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  bool _togglePassword = false;
  bool _isFormValid = false;
  bool isChecked = false;
  String? _imagePath;

  PhoneNumber number = PhoneNumber(isoCode: 'EG');

  OptionItem? drinkSelectedValue;
  final List<OptionItem> drinks = [
    OptionItem(id: 1, title: '5arbosh shay', backendValue: 1),
    OptionItem(id: 2, title: 'Mango', backendValue: 2),
    OptionItem(id: 3, title: 'Coffee', backendValue: 3),
    OptionItem(id: 4, title: 'Sahlb', backendValue: 4),
    OptionItem(id: 5, title: 'Farawla', backendValue: 5),
  ];

  OptionItem? userTypeSelectedValue;
  final List<OptionItem> userType = [
    OptionItem(id: 1, title: 'HouseHold', backendValue: 'user'),
    OptionItem(id: 2, title: 'Restaurant', backendValue: 'restaurant'),
    OptionItem(id: 3, title: 'Supermarket', backendValue: 'super_market'),
  ];

  void _validateForm() {
    setState(() {
      _isFormValid = (formKey.currentState?.validate() ?? false) &&
          (isChecked == true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
      child: Form(
        key: formKey,
        onChanged: _validateForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShowWelcomeMessage(),
              SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                  controller: userNameController,
                  labelText: "Username",
                  validator: (value) {
                    var availableValue = value ?? '';
                    if (availableValue.isEmpty) {
                      return ("Please enter your username");
                    }
                    return null;
                  }),
              CustomTextFormField(
                controller: emailController,
                labelText: "Email",
                hintText: "example@gmail.com",
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail, // Add email validation
              ),
              Text(
                "Phone number",
                style: AppStyles.styleRegular16,
              ),
              SizedBox(height: 8.h),
              CustomInternationalPhoneNumber(
                  number: number, phoneController: phoneController),
              SizedBox(height: 20.h),
              Text(
                "Upload an image (you will use it to login)",
                style: AppStyles.styleRegular16,
              ),
              SizedBox(height: 8),
              FileUploadContainer(
                imagePath: _imagePath,
                onPickImage: (String? imagePath) {
                  setState(() {
                    _imagePath = imagePath!;
                  });
                },
                onClearImage: () {
                  setState(() {
                    _imagePath = null;
                  });
                },
              ),
              SizedBox(height: 10),
              CustomDropdown(
                selectedItem: drinkSelectedValue,
                options: drinks,
                onOptionSelected: (value) {
                  setState(() {
                    drinkSelectedValue = value;
                  });
                },
                hintText: "What is your favourite drink?",
                labelText: "Please answer this question",
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: passwordController,
                labelText: "Password",
                hintText: "Password",
                obscureText: !_togglePassword,
                validator: validatePassword,
                // Add password validation
                trailingIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _togglePassword = !_togglePassword;
                    });
                  },
                  icon: _togglePassword
                      ? const Icon(
                    Icons.remove_red_eye_outlined,
                    size: 22.5,
                  )
                      : SvgPicture.asset(
                    Assets.imagesEyeOff,
                    width: 22.5,
                    height: 22.5,
                  ),
                ),
              ),
              CustomTextFormField(
                controller: passwordConfirmationController,
                labelText: "Confirm password",
                hintText: "Password",
                obscureText: !_togglePassword,
                validator: (value) =>
                    validateConfirmPassword(
                        value, passwordController.text),
                // Add confirm password validation
                trailingIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _togglePassword = !_togglePassword;
                    });
                  },
                  icon: _togglePassword
                      ? const Icon(
                    Icons.remove_red_eye_outlined,
                    size: 22.5,
                  )
                      : SvgPicture.asset(
                    Assets.imagesEyeOff,
                    width: 22.5,
                    height: 22.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomDropdown(
                  selectedItem: userTypeSelectedValue,
                  options: userType,
                  onOptionSelected: (value) {
                    setState(() {
                      userTypeSelectedValue = value;
                    });
                  },
                  hintText: "Please Select",
                  labelText: "Account type"),
              SizedBox(
                height: 8.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    activeColor: Color(0xff5EDA42),
                    side: BorderSide(width: 1, color: Color(0xffB3B3B3)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                        _validateForm(); // Revalidate the form when the checkbox changes
                      });
                    },
                  ),
                  Text.rich(TextSpan(
                      text: 'Agree with ',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontFamily: 'Noto Scans'),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Terms and Conditions',
                            style: TextStyle(
                              fontFamily: 'Noto Scans',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff5EDA42),
                              decorationColor: Color(0xff5EDA42),
                              decoration: TextDecoration.combine(
                                  [TextDecoration.underline]),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // code to open / launch terms of service link here
                              }),
                      ]))
                ],
              ),
              CustomElevatedButton(
                text: "Create Account",
                isEnabled: _isFormValid,
                onPressed: _submitForm,

              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Text.rich(TextSpan(
                    text: 'Aleardy have an account? ',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontFamily: 'Noto Scans'),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Noto Scans',
                            color: Color(0xff5EDA42),
                            decorationColor: Color(0xff5EDA42),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // code to open / launch terms of service link here
                            }),
                    ])),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (formKey.currentState!.validate() && isChecked == true) {
      if (_imagePath == null || userTypeSelectedValue == null ||
          drinkSelectedValue == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please complete all required fields")),
        );
        return;
      }

      BlocProvider.of<AuthenticationBloc>(context).add(SignUpEvent(
        signUpEntity: SignUpEntity(
          userName: userNameController.text,
          email: emailController.text,
          password: passwordController.text,
          passwordConfirmation: passwordConfirmationController.text,
          phone: phoneController.text,
          image: _imagePath!,
          type: userTypeSelectedValue!.backendValue,
          answer: drinkSelectedValue!.backendValue,
        ),
      ));
    }
  }
}
