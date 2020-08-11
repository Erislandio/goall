import 'package:flutter/material.dart';
import 'package:goall/routes/app_routes.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _index,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Theme.of(context).primaryColor,
      selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      onTap: (index) {
        setState(() {
          _index = index;

          if (index == 2) {
            Navigator.of(context).pushNamed(AppRoutes.ACCOUNT);
          }
        });
      },
      items: [
        BottomNavigationBarItem(
          title: Text(""),
          icon: Icon(Icons.map),
        ),
        BottomNavigationBarItem(
          title: Text(""),
          icon: Icon(Icons.search),
        ),
        BottomNavigationBarItem(
          title: Text(""),
          icon: Icon(
            Icons.account_circle,
          ),
        ),
      ],
    );
  }
}
