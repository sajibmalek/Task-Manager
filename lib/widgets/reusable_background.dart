import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/ui/utility/assets_utility/assets_utility.dart';

class AppBackGround extends StatelessWidget {
  const AppBackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SvgPicture.asset(
       AssetsImg.backgroundSVG,
        fit: BoxFit.cover,

      ),
    );
  }
}
