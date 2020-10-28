import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tabsera/athkar/zekr_title.dart';
import 'azkar_categories_list.dart';
import 'favourites.dart';

class Athkar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AthkarState();
  }
}

class _AthkarState extends State<Athkar> {
  final List<Map<String, String>> mappedData = mappedJson;
  final List<String> onlyAzkarList = [];
  var finalCategoryList = [];




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    for (int c = 0; c < mappedData.length; c++) {
      onlyAzkarList.add(mappedData[c]["category"]);
    }
    finalCategoryList = onlyAzkarList.toSet().toList();
    return SafeArea(

      top: true,
      bottom: true,
      child: Stack(
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
            drawerDragStartBehavior: DragStartBehavior.down,
            drawerScrimColor: Theme.of(context).primaryColor,
            body: ZekrTitle(finalCategoryList),
          ),
        ],
      ),
    );
  }
}