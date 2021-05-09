import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'AppDrawer.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  String Userid = FirebaseAuth.instance.currentUser.uid;
  String name = '';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.red,
      ),
      drawer: AppDrawer(),
      body: Container(

        child: ListView(
          children: [
            Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').where('id' ,isEqualTo: Userid ).snapshots(),

              builder: (context, snapshot)
                {


                  if(!snapshot.hasData)
                    {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      );
                    }
                  else{

                    return Container(

                      height: MediaQuery.of(context).size.height/1,

                      child: ListView.builder(
                        itemBuilder: (context, index){
                          name = snapshot.data.docs[index]['Name'];
                          return Container(
                              child:  Column(

                                children: [

                                  SizedBox(height: 20),
                                 Container(
                                    alignment: Alignment.center,
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(32),
                                    ),
                                    child: Image(
                                      height: 100,
                                      image: NetworkImage('https://lh3.googleusercontent.com/proxy/fypeH78ZD6u6TeBnByC8Pnr6L-AEgLtJ9oc3r-C8C6-fyrLPLpwn7f8O4CC87TYpemRZ8WGW-EH-2dag7AZiF1gkrYaetaH1EMzQtG1PZ-iKf0nWQ10kXtVT'),),
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        //Text('Account',style: TextStyle(fontSize: 30,color: Colors.blue),textAlign: TextAlign.center,),
                                        Text('Personal Information',style: TextStyle(fontSize: 20,color: Colors.black87),textAlign: TextAlign.start,),
                                        Divider(color: Colors.blue),
                                        SizedBox(height:20),

                                        Text('Name:',style: TextStyle(fontSize: 20),textAlign: TextAlign.start,),
                                        SizedBox(height:5),
                                        Text(snapshot.data.docs[index]['Name'],style: TextStyle(fontSize: 20,color: Colors.black54),textAlign: TextAlign.start,),
                                        Divider(color: Colors.green),


                                        SizedBox(height:10),
                                        Text('Email:',style: TextStyle(fontSize: 20),textAlign: TextAlign.start,),
                                        SizedBox(height:5),
                                        Text(snapshot.data.docs[index]['email'],style: TextStyle(fontSize: 20,color: Colors.black54),textAlign: TextAlign.start,),
                                        Divider(color: Colors.green),

                                        SizedBox(height:10),
                                        Text('Address:',style: TextStyle(fontSize: 20),textAlign: TextAlign.start,),
                                        SizedBox(height:5),
                                        Text(snapshot.data.docs[index]['address'],style: TextStyle(fontSize: 20,color: Colors.black54),textAlign: TextAlign.start,),
                                        Divider(color: Colors.green),

                                        SizedBox(height:10),
                                        Text('Mobile:',style: TextStyle(fontSize: 20),textAlign: TextAlign.start,),
                                        SizedBox(height:5),
                                        Text(snapshot.data.docs[index]['phone'],style: TextStyle(fontSize: 20,color: Colors.black54),textAlign: TextAlign.start,),
                                        Divider(color: Colors.green),
                                      ],
                                    ),
                                  ),





                                ],
                              )
                          );
                        },
                        itemCount: snapshot.data.docs.length,
                      ),
                    );
                  }
                }
            ),
        ),

          ],
        ),
      ),
    );
  }

}
