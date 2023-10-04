import 'package:flutter/material.dart';
import 'package:task_manager/ui/data/models/login_response.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/services/ApiUrl.dart';
import 'package:task_manager/ui/data/services/network_caller.dart';
import 'package:task_manager/ui/screens/auth/auth_utility.dart';
import 'package:task_manager/ui/screens/auth/verify_screen.dart';
import 'package:task_manager/ui/screens/set_password.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utility/assets_utility/assets_utility.dart';
import 'package:task_manager/ui/utility/assets_utility/string_utility.dart';
import 'package:task_manager/widgets/reusable_background.dart';
import 'package:task_manager/widgets/reusable_text_filed_form.dart';

import '../bottom_nav_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



const String _validMail =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _loginForm= GlobalKey<FormState>();
  bool _isLoginProgress=false;

  Future<void> login() async{
    _isLoginProgress=true;
    if(mounted){
      setState(() {});
    }
    final NetworkResponse response= await NetWorkCaller().postRequest(ApiUrl.login,<String,dynamic>{
      "email":_emailController.text.toString().trim(),
      "password":_passwordController.text.toString()
    },isLogin: true);
    _isLoginProgress=false;
    if(mounted){
      setState(() {});
    }
    if (response.isSuccess) {
      LogInModel logInModel= LogInModel.fromJson(response.body!);
      await AuthUtility.loginPref(logInModel);
      _emailController.clear();
      _passwordController.clear();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomNavScreen()),
            (route) => false);
      }
    }


    else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Center(
          child: Text("Incorrect email or password"),
        )));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const AppBackGround(),
          Form(
            key: _loginForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 64, right: 90),
                  child: const Text(
                    AppString.loginTopText,
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
                Container(

                  width: 310,
                  margin:
                   const   EdgeInsets.only(top: 20, left: 64, right: 35, bottom: 15),
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
                    controller: _emailController,
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
                Container(
                  width: 310,
                  margin: const EdgeInsets.only(left: 64, right: 35, bottom: 15),
                  child: TextFormField(
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter your password";
                      }
                      // if (value?.length != 6) {
                      //   return "Enter the minimum 6 password";
                      // }
                      if (mounted) {
                        setState(() {});
                      }
                      return null;
                    },
                    controller: _passwordController,
                    decoration: InputDecoration(
                        //contentPadding:EdgeInsets.only(),
                        // hintText: "exmaple@gmail.com",
                        label: const Text("Password"),
                        prefixIconColor: Colors.green,
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
                Visibility(
                  visible: _isLoginProgress==false,
                  replacement: const Center(child: CircularProgressIndicator(),),
                  child: InkWell(
                    splashColor:Colors.indigo,
                    onTap: () {
                      if(!_loginForm.currentState!.validate()){
                        return;
                      }
                      login();
                      if(mounted){
                        setState(() {
                        });
                      }
                    },
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
                ),
                  Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    bottom: 12,
                  ),
                  child: TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyScreen()));
                  },
                    child: Text(
                      AppString.forgotText,
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                  Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 12, right: 5),
                      child: Text(
                        AppString.dont_account,
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.normal),
                      ),
                    ),
                      Padding(
                      padding:   EdgeInsets.only(bottom: 12, right: 1),
                      child: TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                      }, child: Text(
                        AppString.signUp,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),)
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
