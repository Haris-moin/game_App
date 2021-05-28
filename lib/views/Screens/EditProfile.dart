import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'Home.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController FirstNameController ;

  TextEditingController AddressController ;

  String Userid = FirebaseAuth.instance.currentUser.uid;
  String FName = 'Your name';
  String Addres = 'Address';
  bool _onFocuseFirstname = false;
  bool _onFocuseLastname = false;
  bool _onFocuseAddress = false;


  void initState() {

    FirstNameController = TextEditingController();
    AddressController = TextEditingController();
  }
  void _toggleFiirstName() {
    setState(() {
      _onFocuseFirstname = !_onFocuseFirstname;

    });
  }
  void _toggleLastName() {
    setState(() {
      _onFocuseLastname = !_onFocuseLastname;

    });
  }

  void _toggleAddress() {
    setState(() {
      _onFocuseAddress = !_onFocuseAddress;

    });
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EditProfile'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              height: 20,
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
                        height: MediaQuery.of(context).size.height/3,
                        width: MediaQuery.of(context).size.width/3,
                        child: ListView.builder(
                          itemBuilder: (context, index){

                             FName = snapshot.data.docs[index]['Name'];
                             Addres = snapshot.data.docs[index]['address'];

                            return Container(

                            );
                          },
                          itemCount: snapshot.data.docs.length,
                        ),
                      );
                    }
                  }
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0.h),
              alignment: Alignment.center,
              child: Text('Basics Info',style: TextStyle(fontSize: 20.sp,color: Colors.black54,fontWeight: FontWeight.w500),),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 6.0.w,right: 2.0.w,top: 5.0.h,bottom: 5.0.h),
                    child: TextField(

                      enabled: _onFocuseFirstname,
                      style: TextStyle(color: Colors.black54),
                      controller: FirstNameController,
                      decoration: InputDecoration(
                        labelText: FName,
                      ),
                    ),

                  ),
                ),

                Container(
                  margin: EdgeInsets.only(right: 5.w),
                  child: IconButton(icon: Icon(Icons.edit),
                    onPressed: (){
                      _toggleFiirstName();

                    },
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 6.0.w,right: 2.0.w,top: 5.0.h,bottom: 5.0.h),
                    child: TextField(
                      enabled: _onFocuseAddress,
                      style: TextStyle(color: Colors.black54),
                      controller: AddressController,
                      decoration: InputDecoration(
                        labelText: Addres
                      ),
                    ),

                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.w),
                  child: IconButton(icon: Icon(Icons.edit),
                    onPressed: (){
                      _toggleAddress();

                    },
                  ),
                ),
              ],
            ),
            Container(
              width: 50.w,
              height: 5.h,
              margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              child:  ElevatedButton(

                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text('Submit',style: TextStyle(fontSize: 14.sp),),
                onPressed: () {
                 if(FirstNameController.text.isNotEmpty && AddressController.text.isNotEmpty)
                   {
                     _onPressed(FirstNameController.text , AddressController.text);

                   }
                else if(FirstNameController.text.isNotEmpty && AddressController.text.isEmpty)
                  {
                    _onEditNameOnly(FirstNameController.text);
                  }
                 else if(FirstNameController.text.isEmpty && AddressController.text.isNotEmpty)
                   {
                     _onEditAddressOnly(AddressController.text);
                   }
                },
              ),
            ),

          ],
        ),
      ),

    );
  }

  EdittAlert(BuildContext context) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text('Your info submitted successfully.'
            ),
            actions: <Widget>[

              FlatButton(
                child: Text("ok",style: TextStyle(fontSize: 16),),
                onPressed: () async{
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      Home()), (Route<dynamic> route) => false);
                },
              ),

            ],
          ),
        );
      },
    );
  }

  void _onPressed(String FirstName,  String address){
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .update({"Name": FirstName,"address": address}).then((_) {
      print("success!");
      EdittAlert(context);
    });
  }
  void _onEditNameOnly(String FirstName)
  {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .update({"Name": FirstName}).then((_) {
      print("success!");
      EdittAlert(context);

    });
  }
    void _onEditAddressOnly(String Address)
    {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser.uid)
          .update({"address": Address}).then((_) {
        print("success!");
     EdittAlert(context);
      });
    }

  }
