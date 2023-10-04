import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/auth/auth_utility.dart';
import 'package:task_manager/ui/screens/bottom_nav_screen.dart';
import 'package:task_manager/widgets/reusable_background.dart';
import 'package:task_manager/widgets/splash_logo.dart';

import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
    const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> navigateLoginPage() async {

    Future.delayed(const Duration(seconds: 3)).then((_)async {
        final   bool isLoggedIn= await AuthUtility.checkLoggedIn();
        if(mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  isLoggedIn? const BottomNavScreen(): const LoginScreen()),
                  (route) => false);
        }
    });
  }

  @override
  void initState() {
    super.initState();
    navigateLoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [AppBackGround(), SplashLogoSVG()],
    );
  }
}
