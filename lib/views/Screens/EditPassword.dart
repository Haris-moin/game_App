import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_app/Model/Providers/Auth_Password_Edit.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'EditProfile.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {

  bool CheckCurrenPasswordValid = true;
  Future <bool> ValidateCurrentPassword(String password) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;

    var auth_Credentials = EmailAuthProvider.credential(email: firebaseUser.email, password: password);

    try{
      var authresult = await firebaseUser.reauthenticateWithCredential(auth_Credentials);

      return authresult.user != null;
    }
    catch(e){
      print(e);
      return false;
    }
  }

  Future <void> UpdatePassword(String password) async{
    var firebaseUser = await FirebaseAuth.instance.currentUser;

    firebaseUser.updatePassword(password);
  }
  bool _obscureText = true;
  var _formKey = GlobalKey<FormState>();


  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  FocusNode textFocusNodeOldPassword;
  FocusNode textFocusNodeNewPassword;
  FocusNode textFocusNodeConfirmPassword;
  TextEditingController textControllerOldPassword;
  TextEditingController textControllerNewPassword;
  TextEditingController textControllerConfirmPassword;


 void initState()
 {
   textControllerOldPassword = TextEditingController();
   textControllerNewPassword = TextEditingController();
   textControllerConfirmPassword = TextEditingController();
   textFocusNodeOldPassword = FocusNode();
   textFocusNodeNewPassword = FocusNode();
   textFocusNodeConfirmPassword = FocusNode();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EditProfile'),
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 5.0.h,bottom: 8.0.h),
                alignment: Alignment.center,
                child: Text('Password Change',style: TextStyle(fontSize: 20.sp,color: Colors.black54,fontWeight: FontWeight.w500),),
              ),

              Container(
                  margin: EdgeInsets.symmetric(vertical: 11, horizontal: 20),
                  child: TextFormField(


                    controller: textControllerOldPassword,
                    autofocus: false,

                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: (){
                          _toggle();
                        },
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Old Password',
                      hintText: "Old Password",
                      fillColor: Colors.white,
                        errorText: CheckCurrenPasswordValid ? null : "please Write your Correct password"

                    ),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 11, horizontal: 20),
                  child: TextFormField(
                    focusNode: textFocusNodeNewPassword,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    controller: textControllerNewPassword,
                    autofocus: false,
                    validator: (value){
                      return textControllerNewPassword.text.isNotEmpty  ? null : "Old password can\'t be empty";
                    },

                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: (){
                          _toggle();
                        },
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'New Password',
                      hintText: "New Password",



                    ),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 11, horizontal: 20),
                  child: TextFormField(
                    focusNode: textFocusNodeConfirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    controller: textControllerConfirmPassword,
                    validator: (value){
                      return textControllerNewPassword.text != value ? "please Enter your validate Password" : null;
                    },

                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: (){
                          _toggle();
                        },
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'ConfirmPassword',
                      hintText: "ConfirmPassword",
                      fillColor: Colors.white,

                    ),
                  )),
              Container(
                width: 50.w,
                height: 5.h,
                margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                child:  ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text('Submit',style: TextStyle(fontSize: 14.sp),),
                  onPressed: () async{

                    CheckCurrenPasswordValid = await ValidateCurrentPassword(textControllerOldPassword.text);

                 if(_formKey.currentState.validate() && CheckCurrenPasswordValid)
                   {
                     UpdatePassword(textControllerNewPassword.text);
                     Navigator.of(context).push(
                       MaterialPageRoute(
                         builder: (context) {
                           return EditProfile();
                         },
                       ),
                     );
                   }
                    },
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }



}
