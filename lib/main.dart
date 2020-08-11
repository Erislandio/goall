import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goall/routes/app_routes.dart';
import 'package:goall/screens/account/account.dart';
import 'package:goall/screens/auth/auth_controller.dart';
import 'package:goall/screens/home_screen.dart';
import 'package:goall/screens/login_screen.dart';
import 'package:goall/screens/search/search.dart';
import 'package:goall/screens/sign_in_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        ),
      ],
      child: MaterialApp(
        title: 'Goall app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(66, 66, 160, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: null,
        routes: <String, WidgetBuilder>{
          AppRoutes.AUTH: (_) => AuthControllerScreen(),
          AppRoutes.LOGIN: (_) => LoginPage(),
          AppRoutes.SIGNIN: (_) => SignInPage(),
          AppRoutes.HOME: (_) => HomeScreen(),
          AppRoutes.ACCOUNT: (_) => Account(),
          AppRoutes.SEARCH: (_) => SearchScreen(),
        },
      ),
    );
  }
}
