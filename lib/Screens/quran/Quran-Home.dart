import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tabsera/Model/QuranModel.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class QHome extends StatefulWidget {
  Surah surah;
  int nomPageF, nomPageL;

  QHome({this.surah, this.nomPageF, this.nomPageL});

  @override
  _QHomeState createState() => _QHomeState();
}

class _QHomeState extends State<QHome> {
  bool checkName=true;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleTitle=TextStyle(
        fontSize: ScreenUtil().setSp(60),
        fontWeight: FontWeight.bold);
    TextStyle textStyleName=TextStyle(
        fontSize: ScreenUtil().setSp(40),
        fontWeight: FontWeight.bold);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body:GestureDetector(
          onTap: (){
            setState(() {
              checkName=!checkName;
            });
          },
          child: Container(
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
                // ignore: unnecessary_statements
                List<InlineSpan> text = [];
                int ayahLenght = widget.surah.ayahs.length;
                for (int b = 0; b < ayahLenght; b++) {
                  if (widget.surah.ayahs[b].text.length > 1) {
                    if (widget.surah.ayahs[b].page == (index + widget.nomPageF)) {
                      text.add(TextSpan(children: [
                        TextSpan(
                            text: widget.surah.ayahs[b].text,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(39),
                                fontWeight: FontWeight.bold))
                      ]));
                      text.add(WidgetSpan(
                          child: ayaNum(
                              widget.surah.ayahs[b].numberInSurah.toString(),
                              context,
                              Theme.of(context).primaryColor)));
                    }
                  }
                }

                return Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(20),
                  ),
                  child: Stack(
                    children: [
                      Text.rich(TextSpan(children: text.map((e) => e).toList())),
                      Transform.translate(
                        offset: Offset(0,MediaQuery.of(context).size.height/1.2),
                        child: Padding(

                          padding: const EdgeInsets.all(8.0),
                          child: checkName==true? Container(
                            padding: EdgeInsets.only(
                              right: ScreenUtil().setHeight(25),
                              left: ScreenUtil().setHeight(25),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(40)),color:Color(0xff41839C)),
                            width: MediaQuery.of(context).size.width,
                            height: ScreenUtil().setHeight(160),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("سورة:",style:  textStyleTitle,),Text(widget.surah.name,style: textStyleName,)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("صفحة:",style: textStyleTitle,),Text((widget.nomPageF+index).toString(),style: textStyleName,)
                                    ],
                                  )
                                ],),
                            ),

                          ):null,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}

Widget ayaNum(String num, context, Color color) {
  return Padding(
    padding: EdgeInsets.only(
      left: ScreenUtil().setWidth(10),
      right: ScreenUtil().setWidth(10),
    ),
    child: Transform.translate(
      offset: Offset(0, 0),
      child: Container(
        width: ScreenUtil().setWidth(60),
        height: ScreenUtil().setHeight(60),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.contain,
          ),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(3)),
            child: Text(
              num,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
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
