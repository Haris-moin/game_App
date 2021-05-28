import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game_app/views/Screens/EditPhoneOtp.dart';
import 'package:game_app/views/Screens/OTPVlidation.dart';
import 'package:sizer/sizer.dart';

class EditPhone extends StatefulWidget {
  @override
  _EditPhoneState createState() => _EditPhoneState();
}

class _EditPhoneState extends State<EditPhone> {


  TextEditingController PhoneController = TextEditingController();
  String Userid = FirebaseAuth.instance.currentUser.uid;
  bool _onFocusephone = false;
  String phone =  '+923********';

  void _togglePhone() {
    setState(() {
      _onFocusephone = !_onFocusephone;

    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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

                            phone = snapshot.data.docs[index]['phone'];


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
              child: Text('Phone',style: TextStyle(fontSize: 20.sp,color: Colors.black54,fontWeight: FontWeight.w500),),
            ),

            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 6.0.w,right: 2.0.w,top: 5.0.h,bottom: 5.0.h),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      enabled: _onFocusephone,
                      style: TextStyle(color: Colors.black54),
                      controller: PhoneController,
                      maxLength: 10,
                      decoration: InputDecoration(
                        labelText: phone,
                        prefix: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text('+92'),
                        ),
                        fillColor: Colors.white,

                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5.w),
                  child: IconButton(icon: Icon(Icons.edit),
                    onPressed: (){
                      _togglePhone();

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
                  if(PhoneController.text.length==10)
                    {
                      _checkNumber(PhoneController.text);
                    }
                  else{
                    IvalidPhoneAlert(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
  _checkNumber(String phone)
  {
    FirebaseFirestore.instance.collection("users").where("phone", isEqualTo: '+92${phone}')
        .get()
        .then((querySnapshot) {
      var query = querySnapshot.docs.first.data();
      RegiterPhoneAlert(context);
      // doc.data() is never undefined for query doc snapshots

    }).onError((error, stackTrace) {
      print(error);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditPhoneOTpScreen(phone: phone)));
    });

  }

  RegiterPhoneAlert(BuildContext context) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text('This phone number is already in use by other user'
            ),

            actions: <Widget>[

              FlatButton(
                child: Text("ok"),
                onPressed: () {

                  Navigator.of(context).pop();
                },
              ),

            ],
          ),
        );
      },
    );
  }
  IvalidPhoneAlert(BuildContext context) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text('Please Enter correct phone number'
            ),

            actions: <Widget>[

              FlatButton(
                child: Text("ok"),
                onPressed: () {

                  Navigator.of(context).pop();
                },
              ),

            ],
          ),
        );
      },
    );
  }
}
