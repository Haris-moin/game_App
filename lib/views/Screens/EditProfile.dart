import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController FirstNameController = TextEditingController()..text = 'Moiz';
  TextEditingController LastNameController = TextEditingController()..text = 'Khan';
  TextEditingController AddressController = TextEditingController()..text = 'North Karachi';

  bool _onFocuseFirstname = false;
  bool _onFocuseLastname = false;
  bool _onFocuseAddress = false;
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
                      enabled: _onFocuseLastname,
                      style: TextStyle(color: Colors.black54),
                      controller: LastNameController,

                    ),

                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.w),
                  child: IconButton(icon: Icon(Icons.edit),
                    onPressed: (){
                      _toggleLastName();

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

                  _onPressed(FirstNameController.text ,LastNameController.text, AddressController.text);

                },
              ),
            ),

          ],
        ),
      ),

    );
  }

  void _onPressed(String FirstName, String LastName, String address){
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .update({"FirstName": FirstName,"LastName": LastName, "address": address}).then((_) {
      print("success!");
    });
  }
}
