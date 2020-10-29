import 'package:flutter_screenutil/screenutil.dart';
import 'package:tabsera/athkar/zekr_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZekrTitle extends StatefulWidget {
  final List<String> finalCategoryList;

  ZekrTitle(this.finalCategoryList);

  @override
  _ZekrTitleState createState() => _ZekrTitleState(finalCategoryList);
}

class _ZekrTitleState extends State<ZekrTitle>
    with SingleTickerProviderStateMixin {
//final List<ZekrObject> azkarList;
  List<String> finalCategoryList;

  _ZekrTitleState(this.finalCategoryList);

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: Duration(seconds: 25),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    double padding = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(128)),
          child: Text(
            'الأذكار',
            style: TextStyle(
              color: Theme.of(context).primaryColorDark,
              fontSize: ScreenUtil().setSp(80),
              fontFamily: 'Tj'
            ),
          )
        ),
        Padding(
          padding: EdgeInsets.only(top: padding *.2),
          child: Divider(
            endIndent: 32,
            indent: 32,
            thickness: 2,
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: padding *.21),
          child: ListView.builder(
              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
              itemCount: this.finalCategoryList.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Center(
                    child: Padding(
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
                        child: GestureDetector(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: index == 0
                                          ? Radius.circular(20.0)
                                          : Radius.circular(5.0),
                                      topRight: index == 0
                                          ? Radius.circular(20.0)
                                          : Radius.circular(5.0),
                                      bottomLeft: index ==
                                          finalCategoryList.length - 1
                                          ? Radius.circular(20.0)
                                          : Radius.circular(5.0),
                                      bottomRight: index ==
                                          finalCategoryList.length - 1
                                          ? Radius.circular(20.0)
                                          : Radius.circular(5.0),
                                    ),
                                    color: Theme.of(context)
                                        .hoverColor,
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 5.0,
                                          color: Colors.black45
                                              .withOpacity(0.5))
                                    ]),
                                width: _screenWidth,
                                height: _screenWidth > _screenHeight
                                    ? _screenHeight / ScreenUtil().setWidth(20) + ScreenUtil().setWidth(6)
                                    : _screenHeight / ScreenUtil().setWidth(30) + ScreenUtil().setWidth(6),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: -190,
                                      top: -200,
                                      child: CircleAvatar(
                                        radius: 132,
                                        backgroundColor: Theme.of(context)
                                            .primaryColorLight,
                                      ),
                                    ),
                                    Positioned(
                                      left: -170,
                                      top: -220,
                                      child: CircleAvatar(
                                        radius: 130,
                                        backgroundColor: Theme.of(context)
                                            .primaryColorDark,
                                      ),
                                    ),
                                    Positioned(
                                      right: -190,
                                      bottom: -215,
                                      child: CircleAvatar(
                                        radius: 132,
                                        backgroundColor: Theme.of(context)
                                            .primaryColorLight,
                                      ),
                                    ),
                                    Positioned(
                                      right: -190,
                                      bottom: -220,
                                      child: CircleAvatar(
                                        radius: 130,
                                        backgroundColor: Theme.of(context)
                                            .primaryColorDark,
                                      ),
                                    ),
                                    Center(
                                      child: Hero(
                                        tag:
                                        this.finalCategoryList[index],
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: Text(
                                            finalCategoryList[index],
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                fontSize: ScreenUtil().setSp(36),
                                                fontWeight:
                                                FontWeight.w500),
                                            maxLines: 2,
                                            textDirection:
                                            TextDirection.rtl,
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        transitionOnUserGestures: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (buildContext) =>
                                    ZekrList.fromFont(
                                      category: finalCategoryList[index],
                                      font: 'Tajawal',
                                    )));
                          },
                        )));
              }),
        ),
      ],
    );
  }

  Widget ZekrTitle(BuildContext context, int index) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          Positioned(
            left: -190,
            top: -200,
            child: CircleAvatar(
              radius: 132,
              backgroundColor: Theme.of(context).bottomAppBarColor,
            ),
          ),
          Positioned(
            left: -170,
            top: -220,
            child: CircleAvatar(
              radius: 130,
              backgroundColor: Theme.of(context).primaryColorDark,
            ),
          ),
          Positioned(
            right: -190,
            bottom: -215,
            child: CircleAvatar(
              radius: 132,
              backgroundColor: Theme.of(context).bottomAppBarColor,
            ),
          ),
          Positioned(
            right: -190,
            bottom: -220,
            child: CircleAvatar(
              radius: 130,
              backgroundColor: Theme.of(context).primaryColorDark,
            ),
          ),
          Hero(
            tag: this.finalCategoryList[index],
            child: Material(
              type: MaterialType.transparency,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
                  child: Text(
                    finalCategoryList[index],
                    style: TextStyle(
                        backgroundColor: Theme.of(context).bottomAppBarColor,
                        color: Theme.of(context).hoverColor,
                        fontSize: ScreenUtil().setSp(36),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Tajawal'),
                    maxLines: 2,
                    textDirection: TextDirection.rtl,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            transitionOnUserGestures: true,
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (buildContext) => ZekrList.fromFont(
                  category: finalCategoryList[index],
                  font: 'Tajawal',
                )));
      },
    );
  }
}
