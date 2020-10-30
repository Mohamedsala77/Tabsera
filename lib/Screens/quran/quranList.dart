
import 'package:flutter/material.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:tabsera/Screens/quran/surah.dart';


class QuranList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: ShiftingTabBar(
          labelStyle: TextStyle(
              fontSize: 20,
              fontFamily: 'Tj'
          ),
          color: Theme.of(context).primaryColorDark,
          tabs: <ShiftingTab>[
            ShiftingTab(
              icon: Icon(Icons.home,
                color: Theme.of(context).backgroundColor,),
              text: 'السور',
            ),
            ShiftingTab(
              icon: Icon(Icons.list,
                  color: Theme.of(context).backgroundColor),
              text: 'الأجزاء',
            ),
          ],
        ),
        // Other parts of the app are exacly same as default TabBar widget
        body: TabBarView(
          children: <Widget>[
            SorahList(),
            Icon(Icons.list),
          ],
        ),
      ),
    );
  }
}