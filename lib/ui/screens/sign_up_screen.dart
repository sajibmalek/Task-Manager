import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/services/network_caller.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';
import 'package:task_manager/widgets/reusable_background.dart';

import '../data/services/ApiUrl.dart';
import '../utility/assets_utility/string_utility.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _lodaing = false;

  // static const String _validMail =/^\S+@\S+\.\S+$/;
  static const String _validNumber = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();

  Future<void> userSignup() async {
    _lodaing = true;
    final NetworkResponse response = await NetWorkCaller()
        .postRequest(ApiUrl.registration, <String, dynamic>{
      "email": _emailController.text.trim().toString(),
      "firstName": _firstNameController.text.trim().toString(),
      "lastName": _lastNameController.text.trim().toString(),
      "mobile": _mobileNumberController.text.trim().toString(),
      "password": _passwordController.text.toString(),
      "photo": ""
    });

    if (response.isSuccess) {
      _lodaing = false;
      _emailController.clear();
      _firstNameController.clear();
      _lastNameController.clear();
      _mobileNumberController.clear();
      _passwordController.clear();
      if (mounted) {
        setState(() {});
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("success")));
    } else {
      _lodaing = false;
      if (mounted) {
        setState(() {});
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppBackGround(),
          SingleChildScrollView(
            child: Form(
              key: _signUpFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 0, right: 40, top: 100, bottom: 20),
                    child: const Text(
                      AppString.join_us,
                      style: TextStyle(
                          fontSize: 28, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    width: 310,
                    margin:
                        const EdgeInsets.only(left: 64, right: 35, bottom: 15),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return AppString.enter_email;
                        }
                        // if (!RegExp(_validMail).hasMatch(value.toString())) {
                        //   return AppString.enter_valid_email;
                        // }
                        if (mounted) {
                          setState(() {});
                        }
                        return null;
                      },
                      controller: _emailController,
                      decoration: InputDecoration(
                          label: const Text("Email"),
                          prefixIconColor: Colors.green,
                          // prefixText: "*******",
                          hintText: "example@gmail.com",
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
                  Container(
                    width: 310,
                    margin:
                        const EdgeInsets.only(left: 64, right: 35, bottom: 15),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return AppString.first_name;
                        }
                        if (mounted) {
                          setState(() {});
                        }
                        return null;
                      },
                      controller: _firstNameController,
                      decoration: InputDecoration(
                          label: const Text("First Name"),
                          prefixIconColor: Colors.green,
                          // prefixText: "*******",
                          hintText: "sajib",
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.person,
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
                  Container(
                    width: 310,
                    margin:
                        const EdgeInsets.only(left: 64, right: 35, bottom: 15),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return AppString.last_name;
                        }
                        if (mounted) {
                          setState(() {});
                        }
                        return null;
                      },
                      controller: _lastNameController,
                      decoration: InputDecoration(
                          label: const Text("Last Name"),
                          prefixIconColor: Colors.green,
                          // prefixText: "*******",
                          hintText: "A. Malek",
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.person,
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
                  Container(
                    width: 310,
                    margin:
                        const EdgeInsets.only(left: 64, right: 35, bottom: 15),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return AppString.enter_mobile_number;
                        }
                        // if (!RegExp(_validNumber).hasMatch(
                        //     value.toString())) {
                        //   return AppString.enter_valid_number;
                        // }
                        if (mounted) {
                          setState(() {});
                        }
                        return null;
                      },
                      controller: _mobileNumberController,
                      decoration: InputDecoration(
                          label: const Text("Mobile Number"),
                          prefixIconColor: Colors.green,
                          // prefixText: "*******",
                          hintText: "0171234xxxx",
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.phone_android,
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
                  Container(
                    width: 310,
                    margin:
                        const EdgeInsets.only(left: 64, right: 35, bottom: 15),
                    child: TextFormField(
                      obscureText: true,
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return AppString.enter_password;
                        }
                        // if (value?.length != 8) {
                        //   return AppString.minimum_length;
                        // }
                        if (mounted) {
                          setState(() {});
                        }
                        return null;
                      },
                      controller: _passwordController,
                      decoration: InputDecoration(
                          filled: true,
                          focusColor: Colors.white,
                          label: const Text("Password"),
                          prefixIconColor: Colors.green,
                          // prefixText: "*******",
                          hintText: "********",
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.password,
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
                  Container(
                    margin: const EdgeInsets.fromLTRB(40, 0, 10, 0),
                    height: 40,
                    width: 250,
                    child: Visibility(
                      visible: _lodaing == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            if (!_signUpFormKey.currentState!.validate()) {
                              return;
                            }
                            userSignup();
                            if (mounted) {
                              setState(() {});
                            }

                            ///  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginScreen()), (route) => false);
                          },
                          child: const Icon(
                            Icons.navigate_next_rounded,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
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
                          child: Text(
                            AppString.signIn,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
