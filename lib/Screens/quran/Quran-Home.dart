import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tabsera/Model/QuranModel.dart';
import 'package:tabsera/server/quranApi.dart';

class QHome extends StatefulWidget {
  Surah surah;
  QHome({this.surah});
  @override
  _QHomeState createState() => _QHomeState();
}

class _QHomeState extends State<QHome> {
  @override
  Widget build(BuildContext context) {
    QuranServer quranServer = QuranServer();
    return Scaffold(
        appBar: AppBar(
          title: Text("القرآن الكريم"),
        ),
        body: Container(
            child: Text(widget.surah.name)
        ));
  }
  Widget ayaNum(String num, context, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Transform.translate(
        offset: Offset(0, 0),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.contain,
            ),
          ),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                num,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: "maddina",
                    color: color),
              ),
            )
          ]),
        ),
      ),
    );
  }
}