import 'package:tabsera/athkar/athkar.dart';
import 'package:tabsera/athkar/favourites.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuList extends StatefulWidget {
  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList>
    with SingleTickerProviderStateMixin {


  var _bottomNavIndex = 0;
  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;

  final iconList = <IconData>[
    Icons.list,
    Icons.bookmark,
  ];

  final List<Widget> wid = <Widget>[
    Athkar(),
    FavouriteList(),
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
          () => _animationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: iconList,
            backgroundColor: Theme.of(context).primaryColorDark,
            activeIndex: _bottomNavIndex,
            activeColor: Theme.of(context).primaryColorLight,
            splashColor: Theme.of(context).primaryColorLight,
            inactiveColor: Theme.of(context).hoverColor,
            notchAndCornersAnimation: animation,
            splashSpeedInMilliseconds: 300,
            notchSmoothness: NotchSmoothness.defaultEdge,
            // gapLocation: GapLocation.end,
            leftCornerRadius: 0,
            rightCornerRadius: 0,
            onTap: (index) => setState(() => _bottomNavIndex = index),
          ),
          body: wid[_bottomNavIndex],
      ),
    );
  }
}
