import 'package:flutter/material.dart';
import 'package:game_app/views/Screens/OTPVlidation.dart';
import 'package:sizer/sizer.dart';

class EditPhone extends StatefulWidget {
  @override
  _EditPhoneState createState() => _EditPhoneState();
}

class _EditPhoneState extends State<EditPhone> {


  TextEditingController PhoneController = TextEditingController()..text = '03412345678';


  bool _onFocusephone = false;


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
                      enabled: _onFocusephone,
                      style: TextStyle(color: Colors.black54),
                      controller: PhoneController,
                      decoration: InputDecoration(


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

                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}
