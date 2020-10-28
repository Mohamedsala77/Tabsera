import 'package:device_preview/device_preview.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
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

    return  DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) {
        return brightness == Brightness.light
            ? ThemeData(
          primaryColorDark: Color(0xff114b5f),
          primaryColor: Color(0xff1a936f),
          primaryColorLight: Color(0xff88d498),
          bottomAppBarColor: Color(0xffc6dabf),
          hoverColor: Color(0xfff3e9d2),
          backgroundColor: Colors.white,
          brightness: brightness,
        )
            : ThemeData(
          primaryColorDark: Color(0xff000000),
          primaryColor: Color(0xff424242),
          primaryColorLight: Color(0xff303030),
          bottomAppBarColor: Color(0xff5fa8d3),
          backgroundColor: Color(0xff212121),
          brightness: brightness,
        );
      },
      themedWidgetBuilder: (context, data) => MaterialApp(
        theme: data,
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
          home:  SplashScreen(),
      ),
    );
  }
}

