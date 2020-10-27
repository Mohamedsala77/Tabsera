
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'Splashs/SplashScreen.dart';

void main() {
  runApp(
      EasyLocalization(
        child:Home(),
        path: "assets",
        saveLocale: true,
        supportedLocales: [
          Locale("ar", "EG"),
          Locale("en", "US"),
        ],
      ));
}
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: Locale("ar","EG"),
      title: "Quran",
      home: SplashScreen(),
    );
  }
}

