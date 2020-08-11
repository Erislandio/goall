import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:goall/screens/home_screen.dart';
import 'package:goall/screens/login_screen.dart';
import 'package:goall/screens/sign_in_screen.dart';
import 'package:goall/screens/splash_screens/splash.dart';
import 'package:provider/provider.dart';

class AuthControllerScreen extends StatefulWidget {
  @override
  _AuthControllerScreenState createState() => _AuthControllerScreenState();
}

class _AuthControllerScreenState extends State<AuthControllerScreen> {
  bool _showPages = false;
  final controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 1500), () {
      setState(() {
        _showPages = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context, listen: true);

    if (user == null) {
      return PageView(
        scrollDirection: Axis.horizontal,
        controller: controller,
        dragStartBehavior: DragStartBehavior.start,
        allowImplicitScrolling: false,
        children: [
          LoginPage(
            controller: controller,
          ),
          SignInPage(
            controller: controller,
          ),
        ],
      );
    }

    return HomeScreen();
  }
}
