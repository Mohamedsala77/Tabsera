import 'dart:math';
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tabsera/Screens/quran/Quran-Home.dart';
import 'package:tabsera/Screens/quran/quranList.dart';
import 'package:tabsera/Screens/quran/surah.dart';
import 'package:tabsera/athkar/athkar.dart';
import 'package:tabsera/athkar/athkar_list.dart';
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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: ScreenUtil().setHeight(300),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 64),
          child: Image.asset(
            'assets/images/logo.png',
            scale: 4,
          ),
        ),
      ),
      body: CircularMenu(
        animationDuration: Duration(milliseconds: 1500),
        toggleButtonPadding: ScreenUtil().setWidth(50),
        toggleButtonSize: ScreenUtil().setWidth(80),
        toggleButtonColor: Theme.of(context).primaryColorDark,
        toggleButtonIconColor: Theme.of(context).backgroundColor,
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
              Navigator.push(context, MaterialPageRoute(builder: (context)=>QuranList()));
            },

            color: Theme.of(context).bottomAppBarColor,
            iconColor: Theme.of(context).primaryColorDark,
            iconSize: ScreenUtil().setWidth(80),
            padding: ScreenUtil().setWidth(30),
          ),
          CircularMenuItem(
            icon: FontAwesomeIcons.kaaba,
            onTap: () {
            },
            color: Theme.of(context).bottomAppBarColor,
            iconColor: Theme.of(context).primaryColorDark,
            iconSize: ScreenUtil().setWidth(80),
            padding: ScreenUtil().setWidth(30),
          ),
          CircularMenuItem(
            icon: FontAwesomeIcons.mosque,
            onTap: () {},
            color: Theme.of(context).bottomAppBarColor,
            iconColor: Theme.of(context).primaryColorDark,
            iconSize: ScreenUtil().setWidth(80),
            padding: ScreenUtil().setWidth(30),
          ),
          CircularMenuItem(
            iconSize: ScreenUtil().setWidth(80),
            padding: ScreenUtil().setWidth(30),
            icon: FontAwesomeIcons.pray,
            onTap: () {},
            color: Theme.of(context).bottomAppBarColor,
            iconColor: Theme.of(context).primaryColorDark,
          ),
          CircularMenuItem(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MenuList()));
            },
            color: Theme.of(context).bottomAppBarColor,
            iconColor: Theme.of(context).primaryColorDark,
            icon: FontAwesomeIcons.prayingHands,
            iconSize: ScreenUtil().setWidth(80),
            padding: ScreenUtil().setWidth(30),
          ),
        ],
      ),
    );
  }
}