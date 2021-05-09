import 'package:flutter/material.dart';
import 'package:game_app/Model/Providers/auth_services_Provider.dart';
import 'package:game_app/views/Screens/History.dart';
import 'package:game_app/views/Screens/Home.dart';
import 'package:game_app/views/Screens/Profile.dart';
import 'package:game_app/views/Screens/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';
import 'Setting.dart';

class AppDrawer extends StatelessWidget {

  Future<void> signOut(BuildContext context)
  async{
    auth_Services_Provider _auth_Provider = Provider.of<auth_Services_Provider>(context, listen: false);
    _auth_Provider.signOut().then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });

  }
  Widget _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Profile",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.home_outlined,
              text: 'Home',
              onTap: () {

                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Home()));
              }),
          _createDrawerItem(
              icon: Icons.settings,
              text: 'Settings',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => settings()),
                );
              }),
          _createDrawerItem(
            icon: Icons.logout,
            text: 'SignOut',
            onTap: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();

              prefs.remove('email');
              signOut(context);
            }
          ),
          Divider(),
          _createDrawerItem(
              icon: Icons.sticky_note_2_outlined,
              text: 'Tickets',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => GameScreen()));
              }),
          _createDrawerItem(
              icon: Icons.sticky_note_2_outlined,
              text: 'Profile',
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UserProfile()));
              }),
          _createDrawerItem(
              icon: Icons.payments_rounded, text: 'Payments', onTap: () {}),
          _createDrawerItem(icon: Icons.history, text: 'History',
          onTap: ()
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => History()),
            );
          }),
        ],
      ),
    );
  }
}
