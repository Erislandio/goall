import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Go",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: "All",
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromRGBO(253, 112, 146, 1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
