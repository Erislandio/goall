import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goall/components/map_container.dart';
import 'package:goall/components/user_image_profile.dart';
import 'package:goall/routes/app_routes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context, listen: false);
    final screen = MediaQuery.of(context).size;

 
    return Scaffold(
      body: SafeArea(
        top: false,
        maintainBottomViewPadding: false,
        child: Container(
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.topCenter,
            children: [
              MapContainer(),
              Positioned(
                bottom: screen.height * 0.02,
                right: 20,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.gps_fixed,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Positioned(
                top: screen.height * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.SEARCH);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: screen.width * 0.8,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 15.0,
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Buscar...",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.ACCOUNT);
                      },
                      icon: UserProfileImage(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
