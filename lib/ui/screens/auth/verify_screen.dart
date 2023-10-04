import 'package:flutter/material.dart';
import 'package:task_manager/ui/data/services/ApiUrl.dart';
import 'package:task_manager/ui/data/services/network_caller.dart';
import 'package:task_manager/ui/screens/auth/otp_verification.dart';
import 'package:task_manager/widgets/reusable_background.dart';

import '../../data/models/network_response.dart';
import '../../utility/assets_utility/string_utility.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}
const String _validMail =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

class _VerifyScreenState extends State<VerifyScreen> {
  bool _emailVerficatinInProgress = false;
  final TextEditingController _emailTEController = TextEditingController();

  Future<void> sendOTPToEmail() async {
    _emailVerficatinInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetWorkCaller()
        .getRequest(ApiUrl.sendOtpToEmail(_emailTEController.text.trim()));
    _emailVerficatinInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpVerification(
                  email: _emailTEController.text.trim(),
                )));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Email verification has been failed!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppBackGround(),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 64, right: 40 ,top: 270,bottom: 8),
                  child: const Text(
                    AppString.verify_screen_top_text,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 80, right: 50,top: 10,bottom: 15),
                  child: const Text(
                    AppString.verify_screen_sub_text,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black

                    ),

                  ),
                ),
                Container(
                  height: 40,
                  width: 310,
                  margin:
                  const   EdgeInsets.only( left: 64, right: 35, bottom: 15),
                  child: TextFormField(
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your email";
                      }
                      if (!RegExp(_validMail).hasMatch(value.toString())) {
                        return "Enter the valid email";
                      }
                      if (mounted) {
                        setState(() {});
                      }
                      return null;
                    },
                    controller: _emailTEController,
                    decoration: InputDecoration(
                      //contentPadding:EdgeInsets.only(),
                      // hintText: "exmaple@gmail.com",
                        label: const Text("Email"),
                        prefixIconColor: Colors.green,
                        hintText: "exmaple@gmail.com",
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.email,
                            size: 20,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.green,
                            ),
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                InkWell(
                  splashColor:Colors.indigo,
                  onTap: () { sendOTPToEmail();},
                  child: Container(
                    margin: const EdgeInsets.only(left: 68, right: 40),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)),
                    width: 310,
                    height: 40,
                    child: const Center(
                      child: Icon(
                        Icons.navigate_next_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12, right: 5),
                      child: Text(
                        AppString.dont_account,
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 12, right: 1),
                        child: TextButton(onPressed: (){

                        }, child: const Text(AppString.signUp,style: TextStyle(color: Colors.green),))
                    ),
                  ],
                )
              ],
            ),
          )
          //top text container

          //sub text container

        ],
      ) ,
    );
  }
}
