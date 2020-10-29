import 'dart:io';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:tabsera/athkar/zekr_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

final List<String> favouriteAzkar = [];

class FavouriteList extends StatefulWidget {
  @override
  _FavouriteListState createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList>
    with TickerProviderStateMixin {
  String fileContent = "";
  List<String> favListItems = [];
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FileUtils.readFromFile().then((contents) {
      setState(() {
        fileContent = contents;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height;
    var _screenWidth = MediaQuery.of(context).size.width;
    if (fileContent.isNotEmpty) {
      var tempContent = fileContent.replaceRange(
          fileContent.length - 1, fileContent.length, '');
      favListItems = tempContent.split(',');
    }
    double padding = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: <Color>[
          Theme.of(context).hoverColor, // The Bright color of the theme
          Theme.of(context).backgroundColor, // The dark color of the theme
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: Stack(
        children: <Widget>[
          Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(100)),
              child: Text(
                'المفضلة',
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: ScreenUtil().setSp(80),
                    fontFamily: 'Tj'),
              )),
          Align(
            alignment: Alignment.topLeft,
            child: Tooltip(
              message: "حذف كل المفضلات",
              preferBelow: false,
              child: IconButton(
                icon: Icon(
                  Icons.delete_sweep,
                  size: ScreenUtil().setWidth(60.0),
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    FileUtils.clearElements();
                    Navigator.of(context).pop();
                    fileContent = '';
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(200)),
            child: Stack(
              children: <Widget>[
                Divider(
                  endIndent: ScreenUtil().setWidth(62),
                  indent: ScreenUtil().setWidth(62),
                  thickness: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                  child: ListView.builder(
                      itemCount:
                          favListItems.isNotEmpty ? favListItems.length : 0,
                      padding: EdgeInsets.only(
                          right: ScreenUtil().setWidth(20), left: ScreenUtil().setWidth(20), bottom: ScreenUtil().setHeight(20)),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (buildContext) => ZekrList.fromFont(
                                      category: favListItems[index],
                                      font: 'Tj',
                                    )));
                          },
                          child: favListItems.isNotEmpty
                              ? Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  height: _screenWidth > _screenHeight
                                      ? _screenHeight / 5.0 + 3.0
                                      : _screenHeight / 10.0 + 3.0,
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).bottomAppBarColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: index == 0
                                            ? Radius.circular(20.0)
                                            : Radius.circular(1.0),
                                        topRight: index == 0
                                            ? Radius.circular(20.0)
                                            : Radius.circular(1.0),
                                        bottomLeft:
                                            index == favListItems.length - 1
                                                ? Radius.circular(20.0)
                                                : Radius.circular(1.0),
                                        bottomRight:
                                            index == favListItems.length - 1
                                                ? Radius.circular(20.0)
                                                : Radius.circular(1.0),
                                      ),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            offset: Offset(0.0, 2.0),
                                            blurRadius: 5.0,
                                            color: Theme.of(context)
                                                .bottomAppBarColor
                                                .withOpacity(0.5))
                                      ]),
                                  child: Center(
                                      child: Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(8), left: ScreenUtil().setWidth(16), right: ScreenUtil().setWidth(16)),
                                    child: Hero(
                                      tag: '${favListItems[index]}',
                                      child: Text(
                                        favListItems[index],
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: ScreenUtil().setSp(38),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        maxLines: 2,
                                        textDirection: TextDirection.rtl,
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )),
                                )
                              : Container(),
                        );
                      }),
                ),
                favListItems.isEmpty ? noItems(context) : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// this widget will appear if there is no items in favourite list
Widget noItems(context) {
  return Center(
      child: Padding(
    padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
    child: Text(
      "قائمة الأذكار المفضلة فارغة !\nلإضافة الأذكار إلى المفضلة اضغط مطولاً على عنوان هذا الذكر أو الدعاء",
      textScaleFactor: 1.2,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).bottomAppBarColor,
      ),
    ),
  ));
}

class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    return File('$path/favourites_list.txt');
  }

  static Future<File> saveToFile(String data) async {
    final file = await getFile;
    String fileContents = await readFromFile();
    var stringWithOutComma = fileContents;
    if (fileContents.isNotEmpty) {
      if (fileContents.endsWith(",")) {}

      var existingElements = stringWithOutComma.split(',');

      if (!existingElements.contains(data)) {
        print(data + " Added Successfully");
        return file.writeAsString("$fileContents$data,");
      } else {
        print(data + " Removed Successfully");
        await removeElement(data);
        String c = await FileUtils.readFromFile();
        if (c.length < 2) {
          return await FileUtils.clearElements();
        }
      }
    } else {
      return file.writeAsString("$fileContents$data,");
    }
  }

  static Future<String> readFromFile() async {
    try {
      final file = await getFile;
      String fileContents = await file.readAsString();
      return fileContents;
    } catch (e) {
      FileUtils.clearElements();
      return "";
    }
  }

  static Future<File> removeElement(String data) async {
    final file = await getFile;
    String fileContents = await file.readAsString();

    var stringWithOutComma = fileContents.replaceRange(
        fileContents.length - 1, fileContents.length, '');
    var existingElements = stringWithOutComma.split(',');
    int elementLocation;

    if (existingElements.contains(data)) {
      for (int index = 0; index < existingElements.length; index++) {
        if (existingElements[index] == data) {
          elementLocation = index;
          break;
        }
      }
    }
    existingElements.removeAt(elementLocation);
    var elementsStringWithComma = existingElements.join(",");
    await file.writeAsString(elementsStringWithComma + ",");
    if (await FileUtils.readFromFile() == "") {
      return await FileUtils.clearElements();
    } else {
      return await file.writeAsString(elementsStringWithComma + ",");
    }
  }

  static Future<File> clearElements() async {
    final file = await getFile;
    return file.writeAsString('');
  }
}

// A Class to Enable Notifications

class EnableNotifications {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    return File('$path/enable_notification.txt');
  }

  static Future<String> readFromFile() async {
    try {
      final file = await getFile;
      String fileContents = await file.readAsString();
      return fileContents;
    } catch (e) {
      return "";
    }
  }

  static Future<File> enable() async {
    final file = await getFile;
    return file.writeAsString('1');
  }

  static Future<File> disable() async {
    final file = await getFile;
    return file.writeAsString('');
  }

  static Future<bool> isActive() async {
    final filecontent = await readFromFile();
    if (filecontent == "1") {
      return true;
    } else {
      return false;
    }
  }
}
