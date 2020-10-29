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
        alignment: AlignmentDirectional.center,
        children: [
      Opacity(
        opacity: 0.1,
        child: Image.asset(
          'assets/images/logo.png',

        ),
      ),
      Image.asset(
        'assets/images/logo.png',
        scale: ScreenUtil().setWidth(8),
      ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: ScreenUtil().setHeight(100),
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: ScreenUtil().setHeight(90),
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ],
      ),
    );
  }
}
