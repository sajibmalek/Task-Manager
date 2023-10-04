import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/data/services/ApiUrl.dart';
import 'package:task_manager/ui/data/services/network_caller.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';
import 'package:task_manager/ui/screens/set_password.dart';

import '../../../widgets/reusable_background.dart';
import '../../data/models/network_response.dart';
import '../../utility/assets_utility/string_utility.dart';

class OtpVerification extends StatefulWidget {
  final String email;

  const OtpVerification({super.key, required this.email});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final TextEditingController _otpTEController = TextEditingController();
  bool _otpVerificationInProgress = false;

  Future<void> verifyOTP() async {
    _otpVerificationInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetWorkCaller()
        .getRequest(ApiUrl.otpVerify(widget.email, _otpTEController.text));
    _otpVerificationInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SetPasswordScreen(
                      email: widget.email,
                      otp: _otpTEController.text,
                    )));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Otp verification has been failed!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppBackGround(),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 64, right: 40, top: 270, bottom: 8),
                child: const Text(
                  AppString.pin_verification,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 80, right: 50, top: 10, bottom: 15),
                child: const Text(
                  AppString.verify_screen_sub_text,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: PinCodeTextField(
                  controller: _otpTEController,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    inactiveColor: Colors.red,

                    // selectedColor: Colors.green
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.white,
                  enableActiveFill: true,
                  // errorAnimationController: errorController,
                  // controller: textEditingController,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                splashColor: Colors.indigo,
                onTap: () {
                  verifyOTP();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 68, right: 40),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5)),
                  width: 310,
                  height: 40,
                  child: const Center(
                    child: Text(
                      AppString.verify,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12, right: 5),
                    child: Text(
                      AppString.have_account,
                      style: TextStyle(
                          fontSize: 11, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 12, right: 1),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                                (route) => false);
                          },
                          child: const Text(
                            AppString.signIn,
                            style: TextStyle(color: Colors.green),
                          ))),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
