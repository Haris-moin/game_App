import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:game_app/Model/Providers/auth_services_Provider.dart';
import 'package:game_app/views/Screens/EditPassword.dart';
import 'package:game_app/views/Screens/EditProfile.dart';
import 'package:game_app/views/Screens/Editphone.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'AppDrawer.dart';
import 'login.dart';

class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {

  Future<void> signOut(BuildContext context)
  async{
    auth_Services_Provider _auth_Provider = Provider.of<auth_Services_Provider>(context, listen: false);
    _auth_Provider.signOut().then((value) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          Login()), (Route<dynamic> route) => false);
    });

  }

  String Name = FirebaseAuth.instance.currentUser.displayName;
  @override
  Widget build(BuildContext context) {
    var _chosenValue;
    return  Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.red,
      ),
      drawer: AppDrawer(),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 3.0.w),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                    child: Text('Account',style: TextStyle(fontSize: 30,color: Colors.blue),textAlign: TextAlign.center,)),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.center,
                  child: Text('setting',style: TextStyle(fontSize: 25)),
                ),
                SizedBox(height: 20,),


                Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0.h),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(color: Colors.black54,),
                      Container(
                          margin: EdgeInsets.all(7),
                          child: Text('Edit Profile',style: TextStyle(fontSize: 25,color: Colors.blue),textAlign: TextAlign.center,)),
                      Divider(color: Colors.black54,),
                      Card(
                        color: Color.fromARGB(255,247,240,240),
                        margin: EdgeInsets.only(top: 2.0.h),
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditProfile()));
                          },
                          child: Container(
                              padding: EdgeInsets.all(20),
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width/1,

                              child: Text('Change Name & Address',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400))

                          ),
                        ),
                      ),
                      Card(
                       color: Color.fromARGB(255,247,240,240),
                    margin: EdgeInsets.only(top: 2.0.h),
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditPassword()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.topLeft,
                            width: MediaQuery.of(context).size.width/1,

                                child: Text('Change Password',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400))

                          ),
                        ),
                      ),
                      Card(
                        color: Color.fromARGB(255,247,240,240),
                        margin: EdgeInsets.only(top: 2.0.h),
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditPhone()));
                          },
                          child: Container(
                              padding: EdgeInsets.all(20),
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width/1,

                              child: Text('Change Phone Number',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400))

                          ),
                        ),
                      ),


                      Divider(color: Colors.black54,),
                    ],
                  ),

                ),

                SizedBox(height: 20,),
                Center(
                  child: Container(

                    width: 40.0.w,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                          overlayColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered))
                                return Colors.red.withOpacity(0.04);
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed))
                                return Colors.red.withOpacity(0.12);
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();

                          prefs.remove('email');
                          signOut(context);
                        },
                        child: Text('Logout',style: TextStyle(color: Colors.white,fontSize: 18))
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}
