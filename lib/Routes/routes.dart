import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qrcode/Home/home.dart';

import '../QrPage/_defaultqrpage.dart';

class router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => AnimatedSplashScreen(
                  splash: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/logo.png', height: 180, width: 160),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                  duration: 1500,
                  splashIconSize: double.maxFinite,
                  pageTransitionType: PageTransitionType.fade,
                  nextScreen: DefaultQr(),
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
