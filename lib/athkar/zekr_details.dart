import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

import 'azkar_categories_list.dart';
import 'favourites.dart';

class ZekrList extends StatefulWidget {
  final String category;

  ZekrList({this.category});

  String font = '';

  ZekrList.fromFont({this.category, this.font = 'Tj'});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ZekrListState.fromFont(category: this.category, font: this.font);
  }
}

class _ZekrListState extends State<ZekrList> {
  final List<Map<String, String>> mappedData = mappedJson;

  final String category;

  _ZekrListState({this.category});

  String font = 'Tj';

  _ZekrListState.fromFont({this.category, this.font = 'Tj'});

  ScrollController _listViewController;

  _scrollListener() {}

  @override
  void initState() {
    _listViewController = ScrollController();
    _listViewController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> finalmappedData = [];
    double screenHeight = MediaQuery.of(context).size.height;
    for (int c = 0; c < mappedData.length; c++) {
      if (this.category == mappedData[c]["category"]) {
        finalmappedData.add(mappedData[c]);
      }
    }
    print("We have ${finalmappedData.length} sub items for ${this.category}");
    String newFont = this.font;

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: <Color>[
              Theme.of(context)
                  .hoverColor, // The Bright color of the theme
              Theme.of(context).backgroundColor, // The dark color of the theme
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          drawerScrimColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Hero(
              tag: this.category,
              child: Material(
                type: MaterialType.transparency,
                child: Text(
                  this.category,
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Tj',
                    fontSize: this.category.length > 14 ? 17.0 : 20.0,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            centerTitle: true,
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  //setState(() {
                  if (newFont == 'Tj') {
                    newFont = 'naskh';
                    Navigator.of(context).pop();
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (buildContext) => ZekrList.fromFont(
                              category: this.category,
                              font: newFont,
                            )));
                  } else {
                    newFont = 'Tj';
                    Navigator.of(context).pop();
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (buildContext) => ZekrList.fromFont(
                              category: this.category,
                              font: newFont,
                            )));
                  }
//                  });
                },
                child: Tooltip(
                  message: "اضغط لتغيير نوع الخط",
                  child: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.6),
                    maxRadius: 20.0,
                    minRadius: 8.0,
                    child: Text(
                      "خط",
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 12.0,
              )
            ],
          ),
          floatingActionButton: finalmappedData.length >= 4
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FloatingActionButton(
                        heroTag: "456",
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.5),
                        tooltip: "الصعود إلى الأعلى",
                        isExtended: true,
                        elevation: 0.0,
                        child: Icon(
                          Icons.keyboard_arrow_up,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          //dddddddddddd
                          if (_listViewController.offset >=
                                  _listViewController.position.minScrollExtent +
                                      0.35 * screenHeight &&
                              !_listViewController.position.outOfRange) {
                            _listViewController.animateTo(
                                _listViewController.offset -
                                    screenHeight +
                                    100.0,
                                duration: Duration(seconds: 1),
                                curve: Interval(0.0, 0.9,
                                    curve: Curves.easeInOut));
                          } else {
                            _listViewController.animateTo(0.0,
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn);
                          }
                        }),
                    SizedBox(
                      height: 5.0,
                    ),
                    FloatingActionButton(
                        heroTag: "123",
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.5),
                        tooltip: "النزول إلى الأسفل",
                        isExtended: true,
                        elevation: 0.0,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          //dddddddddddd
                          if (_listViewController.offset <=
                              _listViewController.position.maxScrollExtent -
                                  0.3 * screenHeight) {
                            _listViewController.animateTo(
                                _listViewController.offset +
                                    screenHeight -
                                    150.0,
                                duration: Duration(seconds: 1),
                                curve: Interval(0.0, 0.9,
                                    curve: Curves.easeInOut));
                          } else {
                            _listViewController.animateTo(
                                _listViewController.position.maxScrollExtent,
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn);
                          }
                        })
                  ],
                )
              : Container(
                  width: 0.0,
                  height: 0.0,
                ),
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                    itemCount: finalmappedData.length,
                    physics: BouncingScrollPhysics(),
                    controller: _listViewController,
                    itemBuilder: (context, index) {
                      var arabicNumber = "مرة واحدة";
                      switch (finalmappedData[index]["count"]) {
                        case "3":
                          arabicNumber = "ثلاث مرات";
                          break;
                        case "4":
                          arabicNumber = "أربع مرات";
                          break;
                        case "7":
                          arabicNumber = "سبع مرات";
                          break;
                        case "10":
                          arabicNumber = "عشر مرات";
                          break;
                        case "100":
                          arabicNumber = "مائة مرة";
                          break;
                      }
                      return GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            FileUtils.saveToFile(this.category);
                            FileUtils.readFromFile().then((contents) {
                              if (contents.contains(this.category)) {
                                _notifyIfAdded(
                                    "تمت إزالة هذا الذكر من المفضلة");
                              } else {
                                _notifyIfAdded(
                                    "تمت إضافة هذا الذكر إلى المفضلة");
                              }
                            }).whenComplete(() {});
                            //cccccccc
                            print(
                                "\n '${this.category}' SUCCESSFULLY ADDED TO THE LIST\n ");
                          });
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 6.0, right: 8.0, left: 8.0),
                            child: Container(
                              height: null,

                              /// if you want to animate it as an AnimatedContainer  then change its height from 0.0 to null
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: index == 0
                                      ? Radius.circular(20.0)
                                      : Radius.circular(5.0),
                                  topRight: index == 0
                                      ? Radius.circular(20.0)
                                      : Radius.circular(5.0),
                                  bottomLeft:
                                      index == finalmappedData.length - 1
                                          ? Radius.circular(20.0)
                                          : Radius.circular(5.0),
                                  bottomRight:
                                      index == finalmappedData.length - 1
                                          ? Radius.circular(20.0)
                                          : Radius.circular(5.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0,
                                        left: 12.0,
                                        right: 12.0,
                                        bottom: 10.0),
                                    child: Center(
                                        child: Column(
                                      textDirection: TextDirection.rtl,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0,
                                                right: 8.0,
                                                left: 8.0),
                                            child: Text(
                                              finalmappedData[index]["zekr"],
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  fontSize: newFont == 'Tj'
                                                      ? 20.0
                                                      : 18.0,
                                                  fontWeight:
                                                      newFont == 'Tj'
                                                          ? FontWeight.normal
                                                          : FontWeight.normal,
                                                  height: newFont == 'Tj'
                                                      ? 1.5
                                                      : 1.7,
                                                  fontFamily: font,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 0.0,
                                                right: 8.0,
                                                left: 8.0),
                                            child: Wrap(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    finalmappedData[index]
                                                        ["reference"],
                                                    textDirection: TextDirection.rtl,
                                                    textAlign: TextAlign.justify,
                                                    style: TextStyle(
                                                        fontSize: newFont == 'Tj'
                                                            ? 16.0
                                                            : 14.0,
                                                        fontWeight:
                                                            newFont == 'Tj'
                                                                ? FontWeight.w400
                                                                : FontWeight.normal,
                                                        height: newFont == 'Tj'
                                                            ? 1.3
                                                            : 1.7,
                                                        fontFamily: font,
                                                        color: Theme.of(context)
                                                            .primaryColorDark),
                                                  ),
                                                ),
                                                Align(
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.share,
                                                      color: Theme.of(context).primaryColorDark,
                                                    ),
                                                    onPressed: () {
                                                      WcFlutterShare.share(
                                                          sharePopupTitle: 'Share',
                                                          subject: 'This is subject',
                                                          text: '${finalmappedData[index]["category"]}\n\n${finalmappedData[index]["zekr"]}\n${finalmappedData[index]["reference"]}\n${finalmappedData[index]["description"]}',
                                                          mimeType: 'text/plain');
                                                    },
                                                  ),
                                                  alignment: Alignment.centerRight,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Container(
                                    color: Theme.of(context).primaryColorLight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        finalmappedData[index]["description"],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Tj',
                                            fontSize: 16,
                                            color:
                                                Theme.of(context).backgroundColor),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                      width: null,
                                      height: null,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(150.0),
                                        gradient: LinearGradient(
                                          colors: [
                                            Theme.of(context).primaryColor,
                                            Theme.of(context).primaryColorDark
                                          ],
                                        ),
                                      ),
                                      constraints: BoxConstraints(
                                          minWidth: 80.0,
                                          maxWidth: 80.0,
                                          minHeight: 30.0,
                                          maxHeight: 35.0),
                                      child: Center(
                                        child: Text(
                                          arabicNumber, //ddddd
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ],
    );

  }


  /// Function to show top notifications when an element is added or removed from favourites list
  void _notifyIfAdded(String message) {
    BotToast.showSimpleNotification(
      title: message,
      animationDuration: Duration(milliseconds: 200),
      animationReverseDuration: Duration(milliseconds: 200),
      enableSlideOff: true,
      closeIcon: Icon(
        Icons.bookmark,
        color: Theme.of(context).cursorColor,
      ),
    );
  }


}
