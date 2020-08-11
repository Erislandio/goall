import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    if (user == null) {
      return CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(""),
      );
    }

    return user.photoUrl.isNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(user.photoUrl),
          )
        : CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              user.email.substring(0, 1).toUpperCase(),
            ),
          );
  }
}
