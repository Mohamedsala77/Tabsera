import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tabsera/Helper/my_event_bus.dart';
import 'package:tabsera/Helper/settings_helpers.dart';
import 'package:tabsera/Model/QuranModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabsera/event/fontsize_event.dart';

class QHome extends StatefulWidget {
  Surah surah;
  int nomPageF, nomPageL;

  QHome({this.surah, this.nomPageF, this.nomPageL});

  @override
  _QHomeState createState() => _QHomeState();
}

class _QHomeState extends State<QHome> with WidgetsBindingObserver {
  static const double maxFontSizeArabic = 50;
  double fontSizeArabic = SettingsHelpers.minFontSizeArabic;
  MyEventBus _myEventBus = MyEventBus.instance;
  StreamSubscription streamEvent;
  bool checkName = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    streamEvent = _myEventBus.eventBus.on<FontSizeEvent>().listen((onData) {
      if (streamEvent != null) {
        setState(() {
          fontSizeArabic = onData.arabicFontSize;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleTitle = TextStyle(
        fontSize: ScreenUtil().setSp(40),
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColorDark);
    TextStyle textStyleName = TextStyle(
        fontSize: ScreenUtil().setSp(40),
        fontWeight: FontWeight.normal,
        fontFamily: 'Tj',
        color: Theme.of(context).primaryColorDark);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            margin: EdgeInsets.all(2),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:  Radius.circular(10),
                topLeft:  Radius.circular(25),
                  topRight:  Radius.circular(25)
                ),
                border: Border.all(
                    width: 10, color: Theme.of(context).primaryColorDark)),
            child: PageView.builder(
              onPageChanged: (index) {
                if (widget.surah.number == 2) {
                  setState(() {
                    index = 2;
                    index++;
                  });
                }
              },
              itemCount: (widget.nomPageL - widget.nomPageF) + 1,
              itemBuilder: (context, index) {
                List<InlineSpan> text = [];
                int ayahLenght = widget.surah.ayahs.length;
                for (int b = 0; b < ayahLenght; b++) {
                  if (widget.surah.ayahs[b].text.length > 1) {
                    if (widget.surah.ayahs[b].page ==
                        (index + widget.nomPageF)) {
                      text.add(TextSpan(children: [
                        TextSpan(
                            text: widget.surah.ayahs[b].text,
                            style: TextStyle(
                                fontSize: fontSizeArabic,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'naskh'))
                      ]));
                      text.add(WidgetSpan(
                          child: ayaNum(
                              widget.surah.ayahs[b].numberInSurah.toString(),
                              context,
                              Theme.of(context).primaryColor)));
                    }
                  }
                }
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(22),
                        bottom: ScreenUtil().setHeight(15),
                        right: ScreenUtil().setHeight(15),
                        left: ScreenUtil().setHeight(15),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            checkName = !checkName;
                          });
                        },
                        child: ListView(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 19,
                                right: MediaQuery.of(context).size.width / 19,
                              ),
                              child: Text.rich(
                                TextSpan(
                                    children: text.map((e) {
                                  return e;
                                }).toList()),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 64.0),
                        child: checkName == true
                            ? Container(
                                padding: EdgeInsets.only(
                                  right: ScreenUtil().setHeight(25),
                                  left: ScreenUtil().setHeight(25),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setWidth(16)),
                                    color: Theme.of(context).bottomAppBarColor),
                                width: MediaQuery.of(context).size.width,
                                height: ScreenUtil().setHeight(80),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.surah.name,
                                        style: textStyleName,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "الصفحة: ",
                                            style: textStyleTitle,
                                          ),
                                          Text(
                                            (widget.nomPageF + index)
                                                .toString(),
                                            style: textStyleName,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 64.0),
                        child: checkName == true
                            ? Container(
                                padding: EdgeInsets.only(
                                  right: ScreenUtil().setHeight(25),
                                  left: ScreenUtil().setHeight(25),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setWidth(16)),
                                    color: Theme.of(context).bottomAppBarColor),
                                width: MediaQuery.of(context).size.width,
                                height: ScreenUtil().setHeight(80),
                                child: Center(
                                  child: Slider(
                                    min: SettingsHelpers.minFontSizeArabic,
                                    max: maxFontSizeArabic,
                                    value: fontSizeArabic,
                                    label: '$fontSizeArabic',
                                    activeColor:
                                        Theme.of(context).primaryColorDark,
                                    inactiveColor: Theme.of(context).hoverColor,
                                    onChanged: (double value) {
                                      setState(() {
                                        fontSizeArabic = value;
                                        _myEventBus.eventBus.fire(
                                            FontSizeEvent()
                                              ..arabicFontSize = value);
                                      });
                                    },
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ),
                  ],
                );
              },
            ),
          )),
    );
  }
}

Widget ayaNum(String num, context, Color color) {
  return Container(
    margin: EdgeInsets.only(
      left: ScreenUtil().setWidth(50),
      right: ScreenUtil().setWidth(10),
    ),
    width: ScreenUtil().setWidth(65),
    height: ScreenUtil().setHeight(65),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/bg.png"),
        fit: BoxFit.contain,
      ),
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(3)),
        child: Text(
          num,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(25),
              fontWeight: FontWeight.bold,
              fontFamily: 'naskh',
              color: color),
        ),
      )
    ]),
  );
}
