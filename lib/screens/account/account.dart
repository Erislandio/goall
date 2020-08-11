import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goall/components/user_image_profile.dart';
import 'package:goall/routes/app_routes.dart';
import 'package:goall/services/auth_service.dart';
import 'package:provider/provider.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final Auth _auth = Auth();
    final FirebaseUser _user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Minha Conta"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Tem certeza que deseja sair?"),
                    actions: [
                      FlatButton(
                        color: Colors.red,
                        child: Text("Sim"),
                        onPressed: () {
                          _auth.signOutGoogle();
                          _auth.signOut();
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.LOGIN);
                        },
                      ),
                      FlatButton(
                        color: Colors.green,
                        child: Text("Não"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Container(
        width: screen.width,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              UserProfileImage(),
              SizedBox(
                height: 30,
              ),
              Text(
                _user != null ? _user.displayName : "",
                style: TextStyle(fontSize: 30, color: Colors.black87),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _user != null ? _user.email : "",
                style: TextStyle(fontSize: 20, color: Colors.black54),
              )
            ],
          ),
        ),
      ),
    );
  }
}
