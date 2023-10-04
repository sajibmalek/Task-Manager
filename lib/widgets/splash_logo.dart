import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/ui/utility/assets_utility/assets_utility.dart';

class SplashLogoSVG extends StatelessWidget {
  const SplashLogoSVG({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
          child: SvgPicture.asset(
            AssetsImg.logoSVG,
            fit: BoxFit.contain,
          ),

      ),
    );
  }
}
