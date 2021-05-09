import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_app/Model/Providers/auth_services_Provider.dart';
import 'package:game_app/views/Screens/EditProfile.dart';
import 'package:game_app/views/Screens/Home.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
   OTPScreen(this.phone);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {



  final TextEditingController _pinPutController = TextEditingController();

  final FocusNode _pinPutFocusNode = FocusNode();
  String _verificationCode;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  Widget justRoundedCornersPinPut() {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(43, 46, 66, 1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: const Color.fromRGBO(126, 203, 224, 1),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: PinPut(
        fieldsCount: 6,
        withCursor: true,
        textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
        eachFieldWidth: 50.0,
        eachFieldHeight: 55.0,
        onSubmit: (String pin)
       async {
          try{
            await FirebaseAuth.instance.signInWithCredential(
              PhoneAuthProvider.credential(verificationId: _verificationCode, smsCode: pin)
            ).then((value) async{
              if(value!= null)
                {
                  print('verified');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Home();
                      },
                    ),
                  );
                }
            });
          }
          catch(e)
         {
           FocusScope.of(context).unfocus();
           _scaffoldkey.currentState.showSnackBar(SnackBar(content: Text('Invalid OTP')));
         }
        },
        focusNode: _pinPutFocusNode,
        controller: _pinPutController,
        submittedFieldDecoration: pinPutDecoration,
        selectedFieldDecoration: pinPutDecoration,
        followingFieldDecoration: pinPutDecoration,
        pinAnimationType: PinAnimationType.fade,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(title: Text('OTP Verification'),backgroundColor: Colors.red,),

      body: Container(
        child: ListView(
           children: [


     Column(

       children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 5.h),
          child: Text('Verify +92-${widget.phone}',style: TextStyle(fontSize: 20.sp),),
        ),
        justRoundedCornersPinPut(),
         Container(
           width: 50.w,
           height: 5.h,
           margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
           child:  ElevatedButton(

             style: ElevatedButton.styleFrom(
               primary: Colors.red,
             ),
             child: Text('Get OTP',style: TextStyle(fontSize: 14.sp),),
             onPressed: () {
               _verifyPhone();
             },
           ),
         ),
       ],
     )
           ],
        ),
      ),
    );
  }

  _verifyPhone() async{

    print(widget.phone);
    print("method call");

    await FirebaseAuth.instance.verifyPhoneNumber(phoneNumber: "+92${widget.phone}",
        verificationCompleted: (PhoneAuthCredential credential) async{
      await FirebaseAuth.instance.signInWithCredential(credential)
          .then((value) async {
         if(value!=null)
           {
             print('Logged in');
           }
         else{
           print('not get credential');
         }
      });
        },
        verificationFailed: (FirebaseAuthException e)
        {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          else{
            print('Exceptions here');
            print(e);
            print('Exceptions here');
          }


        },
        codeSent: (String verificationID, int resendToken)
        async{
          setState(() {
            _verificationCode = verificationID;
          });

          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: _verificationCode);
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout:(String verificationID)
    {
      setState(() {
        _verificationCode = verificationID;
      });
    },
        timeout: Duration(seconds: 60),
    );
  }
  @override
  void initstate()
  {

    super.initState();
    _verifyPhone();
  }
}
