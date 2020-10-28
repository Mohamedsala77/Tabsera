import 'dart:async';

import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:tabsera/Screens/HomePage.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  static String id = "SplashScreen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Center(
              child: Stack(
                alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                color: Theme.of(context).primaryColorLight.withOpacity(.1),
              ),
              Image.asset(
                'assets/images/logo.png',
                scale: 4,
              ),
            ],
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 85,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70,
              color: Theme.of(context).primaryColorDark,
            ),
          )
        ],
      ),
    );
  }
}
