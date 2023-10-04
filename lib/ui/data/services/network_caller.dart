import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/screens/auth/auth_utility.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';

class NetWorkCaller{
  Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url),headers: {
        'token': AuthUtility.userInfo.token.toString()
      });
      log(response.body);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return NetworkResponse(true,response.statusCode, jsonDecode(response.body));
      }
      else if(response.statusCode==401){
          gotoLogIn( );
      }
      else if(response.statusCode==501){
          ScaffoldMessenger.of(TaskManager.globalKey.currentContext!).showSnackBar(const SnackBar(content: Text("Check your internet connection")));
        log(response.statusCode.toString());
      }
      else {
        return NetworkResponse(false,response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(false,-1, null);
  }

  Future<NetworkResponse> postRequest(
      String url, Map<String,dynamic>? body,{bool isLogin=false}) async {
    try {
      Response response = await post(Uri.parse(url),
          headers: {
            //"Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            "Accept": "application/json",
            'token': AuthUtility.userInfo.token.toString()

          },
          body: jsonEncode(body),);

      log(response.statusCode.toString());
      log(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        if (isLogin) {
          gotoLogIn();
        }
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return NetworkResponse(false, -1, null);
  }

  void gotoLogIn( ) async{
    await AuthUtility.logOutPref();
    Navigator.pushAndRemoveUntil(
        TaskManager.globalKey.currentContext!,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }

}