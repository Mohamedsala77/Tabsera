import 'dart:math';
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tabsera/Screens/quran/Quran-Home.dart';
import 'package:tabsera/Screens/quran/surah.dart';
import 'package:tabsera/server/quranApi.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    QuranServer quranServer=QuranServer();
    quranServer.QuranData();
    GlobalKey<CircularMenuState> key = GlobalKey<CircularMenuState>();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xff66677A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: ScreenUtil().setHeight(200),
        centerTitle: true,
        title: Text(
          "appname".tr(),
          style: TextStyle(
              fontFamily: "Tj",
              color: Colors.white,
              fontSize: ScreenUtil().setSp(55)),
        ),
      ),
      body: CircularMenu(
        animationDuration: Duration(milliseconds: 1500),
        toggleButtonPadding: ScreenUtil().setWidth(50),
        toggleButtonSize: ScreenUtil().setWidth(80),
        toggleButtonColor: Colors.white,
        toggleButtonIconColor: Colors.black,
        alignment: Alignment.center,
        startingAngleInRadian: 2 * pi,
        endingAngleInRadian: 2 * pi,
        key: key,
        items: [
          CircularMenuItem(
            icon: FontAwesomeIcons.quran,
            onTap: () {
             
            EasyLocalization.of(context).locale=Locale("ar", "EG");
            print(EasyLocalization.of(context).locale);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SorahList()));
            },

            color: Colors.green,
            iconColor: Colors.black,
            iconSize: ScreenUtil().setWidth(80),
            padding: ScreenUtil().setWidth(30),
          ),
          CircularMenuItem(
            icon: FontAwesomeIcons.kaaba,
            onTap: () {
            },
            color: Colors.yellowAccent.shade700,
            iconColor: Colors.black,
            iconSize: ScreenUtil().setWidth(80),
            padding: ScreenUtil().setWidth(30),
          ),
          CircularMenuItem(
            icon: FontAwesomeIcons.mosque,
            onTap: () {},
            color: Colors.grey,
            iconColor: Colors.black,
            iconSize: ScreenUtil().setWidth(80),
            padding: ScreenUtil().setWidth(30),
          ),
          CircularMenuItem(
            iconSize: ScreenUtil().setWidth(80),
            padding: ScreenUtil().setWidth(30),
            icon: FontAwesomeIcons.pray,
            onTap: () {},
            color: Colors.redAccent,
            iconColor: Colors.black,
          ),
          CircularMenuItem(
            onTap: () {},
            color: Colors.deepPurple,
            iconColor: Colors.black,
            icon: FontAwesomeIcons.prayingHands,
            iconSize: ScreenUtil().setWidth(80),
            padding: ScreenUtil().setWidth(30),
          ),
        ],
      ),
    );
  }
}