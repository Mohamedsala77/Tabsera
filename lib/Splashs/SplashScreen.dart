import 'dart:async';

import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:tabsera/Screens/HomePage.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  static String id="SplashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  
  @override


  void initState() {
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomePage())));

  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return Scaffold(
      backgroundColor: Color(0xff000000),
      body: Center(
        child: Column(children: [
          SizedBox(height: ScreenUtil().setHeight(85),),
          Image.asset('assets/images/6208.jpg',fit: BoxFit.cover,),
        ],)
      ),
    );
  }
}

