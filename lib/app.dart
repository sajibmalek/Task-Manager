import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_task.dart';
import 'package:task_manager/ui/screens/bottom_nav_screen.dart';
import 'package:task_manager/ui/screens/bottom_nav_screens/new_task_nav_screen.dart';
import 'package:task_manager/ui/screens/set_password.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';
import 'package:task_manager/ui/screens/update_profile.dart';


import 'ui/screens/auth/login_screen.dart';

class TaskManager extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey= GlobalKey<NavigatorState>();
  const TaskManager({super.key});

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManager.globalKey,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid:false,
      title: 'Task Manager',
      theme: ThemeData(brightness: Brightness.light,
      primarySwatch: Colors.green,
      inputDecorationTheme: InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
              // hintText: "exmaple@gmail.com",
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(5)))),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode:ThemeMode.system,
      home: const SplashScreen()
    );
  }
}
