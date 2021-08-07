import 'package:flutter/material.dart';
import 'package:shopping_app/components/loading.dart';
import 'package:shopping_app/models/user.dart';
import 'package:shopping_app/screens/others/contactUs_screen.dart';
import 'package:shopping_app/screens/others/profile_screen.dart';
import 'package:shopping_app/screens/others/settings_screen.dart';
import 'package:shopping_app/screens/starters/splash_screen.dart';
import 'package:shopping_app/services/auth.dart';
import 'package:shopping_app/services/database.dart';
import 'package:shopping_app/shared/constants.dart';

class SideDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();
  final DatabaseService _firebaseServices = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final uid = _firebaseServices.getUserId();

    return Drawer(
      child: StreamBuilder<UserData>(
          stream: DatabaseService(uid: uid).userData,
          builder: (context, snapshot) {
            UserData? userData = snapshot.data;
            if (!snapshot.hasData) {
              return Loading();
            }

            return ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(''),
                  accountEmail: Text(''),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: kwhite,
                    child: Text(
                      userData!.name[0],
                      style: TextStyle(
                          fontSize: 40.0,
                          color: kpurple,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/drawer.jpg'))),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: kpurple,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(
                          color: kwhite,
                          fontWeight: FontWeight.bold,
                          height: 1.5),
                      children: [
                        TextSpan(
                          text: "${userData.name}\n",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextSpan(
                          text: "${userData.email}\n",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home, color: kdeepPurple),
                  title: Text("Home", style: drawer),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: kdeepPurple),
                  title: Text("Settings", style: drawer),
                  onTap: () {
                    Navigator.pushNamed(context, SettingsScreen.routeName);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_circle, color: kdeepPurple),
                  title: Text('Profile', style: drawer),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                                uid: uid,
                                email: userData.email,
                              )),
                    );
                  },
                ),
                Divider(thickness: 2),
                ListTile(
                  leading: Icon(Icons.contacts, color: kdeepPurple),
                  title: Text("Contact Us", style: drawer),
                  onTap: () {
                    Navigator.pushNamed(context, ContactUsScreen.routeName);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person, color: kdeepPurple),
                  title: const Text('Logout', style: drawer),
                  onTap: () async {
                    await _auth.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, SplashScreen.routeName, (route) => true);
                  },
                ),
              ],
            );
          }),
    );
  }
}
