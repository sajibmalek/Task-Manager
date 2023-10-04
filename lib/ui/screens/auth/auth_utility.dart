import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/ui/data/models/login_response.dart';

class AuthUtility{
  AuthUtility._();
static LogInModel userInfo=LogInModel();

  static Future<LogInModel> getUserInfo() async{

    SharedPreferences sharedpref= await SharedPreferences.getInstance();
    String value= sharedpref.getString('user-info')!;
     return LogInModel.fromJson(jsonDecode(value));
  }

  static Future<void> updateUserInfo(Data data) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    userInfo.data = data;
    await sharedPrefs.setString('user-info', jsonEncode(userInfo.toJson()));
  }

  static Future<void> loginPref(LogInModel logInModel) async{
    SharedPreferences sharedpref= await SharedPreferences.getInstance();
    await sharedpref.setString('user-info', jsonEncode( logInModel.toJson()));
    userInfo=logInModel;
  }

  static Future<void> logOutPref() async{
    SharedPreferences sharedpref= await SharedPreferences.getInstance();
    await sharedpref.clear();
  }

  static Future<bool> checkLoggedIn() async{
    SharedPreferences sharedpref= await SharedPreferences.getInstance();
    bool isLogin= sharedpref.containsKey('user-info');
    if(isLogin){
    userInfo=  await getUserInfo();
    }
    return isLogin;
  }

}