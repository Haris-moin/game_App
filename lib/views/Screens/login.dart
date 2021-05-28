import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:game_app/Model/Providers/auth_services_Provider.dart';
import 'package:game_app/views/Screens/Home.dart';
import 'package:provider/provider.dart';
import 'EditProfile.dart';
import 'file:///D:/game-main/lib/views/Screens/signup.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _obscureText = true;

Future<bool> _OnBackPrssed(){
  return showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      title: Text('Are you sure'),
      content: Text('You are going to exit this application'),
      actions: [
        ElevatedButton(

          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: Text('no',),
          onPressed: () {
          Navigator.of(context).pop(false);
          },
        ),
        ElevatedButton(

          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: Text('yes',),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  });
}
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _isRegistering = false;
  TextEditingController textControllerEmail;
  TextEditingController textControllerPassword;
  bool _isEditingEmail = false;
  FocusNode textFocusNodeEmail;
  FocusNode textFocusNodePassword;
  bool _isEditingPassword = false;

  @override
  void initState() {
    textControllerEmail = TextEditingController();
    textControllerPassword = TextEditingController();
    textControllerEmail.text = null;
    textControllerPassword.text = null;
    textFocusNodeEmail = FocusNode();
    textFocusNodePassword = FocusNode();

    super.initState();
  }



  String _validateEmail(String value) {
    value = value.trim();

    if (textControllerEmail.text != null) {
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return 'Enter a correct email address';
      }
    }

    return null;
  }

  String _validatePassword(String value) {
    value = value.trim();
    if (textControllerPassword.text != null) {
      if (value.isEmpty) {
        return 'Password can\'t be empty';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Game'),backgroundColor: Colors.red,),
      body:WillPopScope(
        onWillPop: _OnBackPrssed,
        child:  Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 34.0,
                      color: Colors.blue,
                      fontWeight: FontWeight.w700),
                ),
              ),

              Container(
                  margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 20),
                  child: TextField(
                    focusNode: textFocusNodeEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: textControllerEmail,
                    autofocus: false,
                    onChanged: (value) {
                      setState(() {
                        _isEditingEmail = true;
                      });
                    },
                    onSubmitted: (value) {
                      textFocusNodeEmail.unfocus();
                      FocusScope.of(context).requestFocus(textFocusNodePassword);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: "Email",
                      fillColor: Colors.white,
                      errorText: _isEditingEmail
                          ? _validateEmail(textControllerEmail.text)
                          : null,
                      errorStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                      ),
                    ),
                  )),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 20),
                  child: TextField(
                    focusNode: textFocusNodePassword,

                    textInputAction: TextInputAction.next,
                    controller: textControllerPassword,
                    autofocus: false,
                    obscureText: _obscureText,

                    onChanged: (value) {
                      setState(() {
                        _isEditingPassword = true;
                      });
                    },

                    onSubmitted: (value) {
                      textFocusNodePassword.unfocus();
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                        onPressed: (){
                          _toggle();
                        },
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Password',

                      hintText: "Password",
                      fillColor: Colors.white,
                      errorText: _isEditingPassword
                          ? _validatePassword(textControllerPassword.text)
                          : null,
                      errorStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                      ),
                    ),
                  )),

              Container(
                width: 50.w,
                height: 5.h,
                margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 50),
                child:  ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  child: Text('Sign In',style: TextStyle(fontSize: 14.sp),),
                  onPressed: () {
                    ValidateAlert(textControllerEmail.text, textControllerPassword.text, context);
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        'Don\'t have account?',
                        style: TextStyle(
                          fontSize:16.0,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 2.0.w),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Registration()),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<Void> _SignIn(String email,String password, BuildContext context)
  async{
    auth_Services_Provider _auth_Provider = Provider.of<auth_Services_Provider>(context, listen: false);

    try{
      _auth_Provider.signInWithEmailPassword(email, password).then((result){
        if(result !=null)
        {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Home();
              },
            ),
          );
        }
      }).catchError((error)
      {
        print('SigIn Error: $error');
        LoginAlert(context);
      });
    }
    catch(e)
    {
      print(e);
    }
  }

  LoginAlert(BuildContext context ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text('incorrect email or password'
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
  ValidateAlert(String email, String password,BuildContext context) {
    if( textControllerPassword.text.isEmpty ||  textControllerEmail.text.isEmpty )
    {

      final snackBar = SnackBar(

        content: Text('Please Fill all details'),
        action: SnackBarAction(

          label: 'ok',

          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else{
      _SignIn(email ,password  ,context);
    }

  }


}
