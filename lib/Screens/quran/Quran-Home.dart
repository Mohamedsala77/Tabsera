import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tabsera/Model/QuranModel.dart';
import 'package:tabsera/server/quranApi.dart';

class QHome extends StatefulWidget {
  @override
  _QHomeState createState() => _QHomeState();
}

class _QHomeState extends State<QHome> {
  @override
  Widget build(BuildContext context) {
    QuranServer quranServer = QuranServer();
    return Scaffold(
        appBar: AppBar(
          title: Text("قرأن كريم"),
        ),
        body: Container(
          child: FutureBuilder(
              future: quranServer.QuranData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Surah> surah = snapshot.data;
                  return Container(
                    child: PageView.builder(
                        itemCount: 603,
                        itemBuilder: (context, index) {
                          List<InlineSpan> text = [];
                          List<String> surahName = [];
                          for (int i = 0; i < surah.length; i++) {
                            int ayahLenght = surah[i].ayahs.length;
                            for (int b = 0; b < ayahLenght; b++) {
                              if(surah[i].ayahs[b].text.length>1) {
                                if (surah[i].ayahs[b].page == (index + 1)) {
                                  text.add(TextSpan(children: [
                                    TextSpan(text: surah[i].ayahs[b].text,
                                        style: TextStyle(fontSize: 12))
                                  ]));
                                  text.add(WidgetSpan(child: ayaNum(
                                      surah[i].ayahs[b].numberInSurah
                                          .toString(), context, Theme
                                      .of(context)
                                      .primaryColor)));
                                  if (surah[i].ayahs[b].page == 48) {}
                                  if (i <= surah[i].ayahs[b].text.length) {
                                    surahName.add(surah[i].name);
                                  } else {
                                    surahName.add(surah[i + 1].name);
                                  }
                                }
                              }else{
                                text.add(TextSpan(children: [
                                  TextSpan(text: surah[1].ayahs[0].text,
                                      style: TextStyle(fontSize: 12))
                                ]));
                                text.add(WidgetSpan(child: ayaNum(
                                    surah[1].ayahs[0].numberInSurah
                                        .toString(), context, Theme
                                    .of(context)
                                    .primaryColor)));
                              }
                            }
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                  TextSpan(
                                    children: text.map((e) => e).toList()
                                  )
                              )                           ,
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                (index + 1).toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 30),
                              ),
                              Text(
                                surahName[1].toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 30),
                              )
                            ],
                          );
                        }),
                  );
                } else {
                  return Center(

                    child: CircularProgressIndicator(),
                  );
                }
              }),
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


