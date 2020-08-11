import 'package:flutter/material.dart';
import 'package:goall/routes/app_routes.dart';

class AppBarCustom extends StatelessWidget {
  final Color colorTheme;

  AppBarCustom({this.colorTheme});

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      elevation: 0,
      backgroundColor: colorTheme,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.ACCOUNT);
          },
          icon: Icon(Icons.person),
          color: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}
