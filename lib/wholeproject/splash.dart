import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chess_bot/wholeproject/Auth/login.dart';
import 'package:chess_bot/wholeproject/Dashboard/dashboard.dart';
import 'package:chess_bot/wholeproject/More/constapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final colorizeColors = [
    Colors.white,
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
  final colorizeTextStyle = const TextStyle(
    fontSize: 40.0,
  );
  @override
  void initState() {
    SupportApi();
    super.initState();
    Aman();
    // Timer(const Duration(seconds: 5), () => Get.off(const MainMenuView()));

  }
  Aman() async {
    String result = await PlatformDeviceId.getDeviceId;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('uuid', result);

    final userid=prefs.getString("userId")??"0";
    userid!="0"?
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>bottom()));
    }):
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>login()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        // color: const Color(0xFF1F2224),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/splashlogo.jpg"),
                // Lottie.asset("assets/splash.json"),
                // const SizedBox(
                //   height: 60,
                // ),
                AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'RealmoneyChess',
                      textStyle: colorizeTextStyle,
                      colors: colorizeColors,
                    ),
                  ],
                  isRepeatingAnimation: true,
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
