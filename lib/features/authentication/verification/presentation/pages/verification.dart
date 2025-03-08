import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/core/widgets/custom_elevated_button.dart';
import 'package:save_bite/features/authentication/verification/domain/entity/resend_code_entity.dart';
import 'package:save_bite/features/authentication/verification/presentation/bloc/otp_bloc.dart';
import 'package:save_bite/features/authentication/verification/domain/entity/check_code_entity.dart';
import 'package:save_bite/features/authentication/verification/presentation/pages/approved_verification.dart';
import 'package:save_bite/features/authentication/verification/presentation/widgets/verification_container.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String otpToken; // Initial OTP token received from sign-up
  final String email; // User's email to which OTP was sent

  const OTPVerificationScreen({
    Key? key,
    required this.otpToken,
    required this.email,
  }) : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  // UI State variables
  bool _isValid = false; // Checks if OTP fields are fully filled
  bool _isError = false; // Determines if error state should be shown
  bool _isResendDisabled = false; // Disables resend button temporarily

  String _otpToken = ''; // Stores the OTP token (can change on resend)

  // List of controllers for each OTP input box
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _otpToken =
        widget.otpToken; // Initialize with the token received from sign-up

    // Attach listener to all OTP input controllers to validate input
    for (var controller in _controllers) {
      controller.addListener(_validateInput);
    }
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  /// Validates the OTP input fields and updates `_isValid` state
  void _validateInput() {
    setState(() {
      _isValid = _controllers.every(
        (controller) =>
            controller.text.isNotEmpty &&
            RegExp(r'^\d$').hasMatch(controller.text),
      );
    });
  }

  /// Sends OTP verification request
  void _verifyOTP() {
    final otpCode = _controllers.map((c) => c.text.trim()).join();
    if (otpCode.length != 4 || otpCode.contains(" ")) {
      setState(() => _isError = true);
      return;
    }

    print("🔹 OTP Entered: '$otpCode'");
    print("🔹 Token being sent for verification: '$_otpToken'");

    if (otpCode.length == 4 && _otpToken.isNotEmpty) {
      context.read<OTPBloc>().add(
            CheckCodeEvent(
              checkCodeEntity: CheckCodeEntity(
                otp: otpCode,
                otp_token: _otpToken, // ✅ Include OTP token
              ),
            ),
          );
    } else {
      setState(() {
        _isError = true;
      });
    }
  }

  /// Handles OTP resend request
  void _resendCode() {
    setState(() {
      _isResendDisabled = true; // Temporarily disable resend button
    });

    print("📤 Resending OTP to ${widget.email}");

    // Dispatch resend event
    context.read<OTPBloc>().add(
          ResendCodeEvent(
              resendCodeEntity: ResendCodeEntity(email: widget.email)),
        );

    // Enable resend button after 30 seconds
    Timer(const Duration(seconds: 30), () {
      setState(() {
        _isResendDisabled = false;
      });
    });
  }

  int _resendCooldown = 60; // 60 seconds
  Timer? _timer;

  void startCooldown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendCooldown > 0) {
        setState(() {
          _resendCooldown--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<OTPBloc, OTPState>(
          listener: (context, state) {
            if (state is ResendOtpSuccess) {
              final newOtpToken =
                  state.resendCodeResponseEntity.otpToken?.trim() ?? '';
              if (newOtpToken.isNotEmpty) {
                setState(() {
                  _otpToken = newOtpToken; // Update OTP token
                  _isError = false; // Reset error state on successful resend
                });
                print("🔄 Updated OTP Token: '$_otpToken'");
              } else {
                print(
                    "🚨 Error: Resend response did NOT contain an OTP token!");
              }
            } else if (state is CheckCodeSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Verified successfully!")),
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ApprovedVerification()),
              );
            } else if (state is ErrorOTPState) {
              setState(() {
                _isError = true; // Show error state on incorrect OTP
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.message),
                    duration: Duration(seconds: 3)),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingOTPState) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    Text("Verification!", style: AppStyles.styleMedium23),
                    const SizedBox(height: 10),
                    Text(
                      "Enter the code sent to ${widget.email}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Noto Sans',
                        color: Color(0xffB3B3B3),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 60),

                    // OTP Input Fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        4,
                        (index) => VerificationContainer(
                          isValid: _isValid,
                          isError: _isError, // Change color if error occurs
                          controller: _controllers[index],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Verify Button
                    CustomElevatedButton(
                      text: "Verify",
                      isEnabled: _isValid,
                      onPressed: _isValid ? _verifyOTP : null,
                    ),

                    const SizedBox(height: 40),

                    // Resend OTP Link
                    Text.rich(
                      TextSpan(
                        text: "Didn't get the code? ",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Noto Sans',
                        ),
                        children: [
                          TextSpan(
                            text: "Click to resend",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _isResendDisabled ? null : _resendCode,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
