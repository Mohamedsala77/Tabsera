import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabsera/Model/QuranModel.dart';
import 'package:tabsera/server/quranApi.dart';

import 'Quran-Home.dart';


class SorahList extends StatefulWidget {
  @override
  _SorahListState createState() => _SorahListState();
}

class _SorahListState extends State<SorahList> {
  @override
  Widget build(BuildContext context) {
    QuranServer quranServer = QuranServer();
    return FutureBuilder(
        future: quranServer.QuranData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Surah> surah = snapshot.data;
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: 114,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    color: (index % 2 == 0
                        ? Color(0xff457b9d).withOpacity(.2)
                        : Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height:  ScreenUtil().setWidth(70),
                                width:  ScreenUtil().setWidth(70),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/sura_num.png",
                                    ),
                                  ),
                                ),
                                child: Text(
                                  surah[index].number.toString(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize:  ScreenUtil().setSp(36), color: Color(0xff457b9d)),
                                ),
                              ),

                              SizedBox(
                                width: ScreenUtil().setWidth(30),
                              ),
                              Text(
                                surah[index].name.toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(40),
                                  color: Color(0xff1d3557),
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                      width: 1,
                                      color: (index % 2 == 0
                                          ? Color(0xff1d3557)
                                          : Color(0xff457b9d)))),
                              child: Icon(Icons.play_arrow_outlined,
                                  color: (index % 2 == 0
                                      ? Color(0xff1d3557)
                                      : Color(0xff457b9d))),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    // List<Ayahs> ayah = snapshot.data;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => QHome(
                              surah: surah[index],
                              // surah: surah[index],
                            ))));
                  },
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}