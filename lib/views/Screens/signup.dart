

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:game_app/Model/Providers/auth_services_Provider.dart';
import 'package:game_app/views/Screens/OTPVlidation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'login.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration > {

  int finalDate ;

  getCurrentDate(){

    setState(() {

      finalDate = DateTime.now().millisecondsSinceEpoch ;

    });

  }

  bool _checkEmailExist= false;
  bool _checkPhoneExist = false;
  bool _obscureText = true;


  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  bool _isRegistering = false;
  TextEditingController textControllerEmail;
  TextEditingController textControllerOTP;
  TextEditingController textControllerPassword;
  TextEditingController textControllerConfirmPassword;
  TextEditingController textControllerFirstName;
  TextEditingController textControllerLastName;

  TextEditingController textControllerAddress;
  TextEditingController textControllerPhone;
  bool _isEditingEmail = false;
  FocusNode textFocusNodeEmail;
  FocusNode textFocusNodeOTP;
  FocusNode textFocusNodePassword;
  FocusNode textFocusNodeConfirmPassword;
  FocusNode textFocusNodeFirstName;
  FocusNode textFocusNodeLastName;

  FocusNode textFocusNodeAddress;
  FocusNode textFocusNodePhone;

  bool _isEditingPassword = false;
  bool _isEditingConfirmPassword = false;
  bool _isEditingPhone = false;
  bool _isEditingFirstName = false;
  bool _isEditingLastName = false;

  bool _isEditingAddress= false;

  void initState() {
    textControllerOTP = TextEditingController();
    textControllerEmail = TextEditingController();
    textControllerPassword = TextEditingController();
    textControllerConfirmPassword = TextEditingController();
    textControllerFirstName = TextEditingController();
    textControllerLastName = TextEditingController();

    textControllerPhone = TextEditingController();
    textControllerAddress = TextEditingController();
    textFocusNodeOTP = FocusNode();
    textFocusNodeEmail = FocusNode();
    textFocusNodePassword = FocusNode();
    textFocusNodeConfirmPassword = FocusNode();
    textFocusNodeFirstName = FocusNode();
    textFocusNodeLastName = FocusNode();

    textFocusNodeAddress = FocusNode();
    textFocusNodePhone = FocusNode();

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

String _validateConfirmPassword(String value)
{
  value = value.trim();
  if(value.isEmpty)
    {
      return 'Password cant\'t be empty';
    }
  else if(textControllerPassword.text!= textControllerConfirmPassword.text)
    {
      return 'wrong password';
    }
  return null;
}


  String _validateFirstName(String value) {
    value = value.trim();

      if (value.isEmpty ) {
        return 'Name can\'t be empty';
      }

    return null;
  }
  String _validateLastName(String value) {
    value = value.trim();

    if (value.isEmpty ) {
      return 'Name can\'t be empty';
    }

    return null;
  }
  String _validateAddress( String value)
  {
    value = value.trim();
    if(value.isEmpty)
    {
      return 'Address can\'t be empty';
    }
    return null;
  }
  String _validatePhone(String value) {
    value = value.trim();
    if (textControllerPhone.text != null) {
      if (value.isEmpty) {
        return 'Phone no can\'t be empty';
      }
    }
    return null;
  }

Future<void> _SignUp(String email, String password,String FirstName ,String LastName ,String address,String phone,int Date,BuildContext context)
  async {
    auth_Services_Provider _auth_Provider = Provider.of<auth_Services_Provider>(context, listen: false);

    try{
      await   _auth_Provider.registerWithEmailPassword(email,password,FirstName,LastName,address,phone,Date).then((result) {
        if (result != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return OTPScreen(textControllerPhone.text);
              },
            ),
          );
        }
        print(result);
      }).catchError((error) {
        print('Registration Error: $error');
        RegiterAlert(context);
      });
    }
    catch(e)
    {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game',style: TextStyle(fontSize: 20.sp),),
        backgroundColor: Colors.red,
      ),
      body: Container(
          child: ListView(
            children: [ Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 2.h, bottom: 2.h),
                  child: Text(
                    'SignUp',
                    style: TextStyle(
                        fontSize: 34.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.w700),
                  ),
                ),

                Container(
                    margin: EdgeInsets.symmetric(vertical: 11, horizontal: 20),
                    child: TextField(
                      focusNode: textFocusNodeFirstName,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: textControllerFirstName,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          _isEditingFirstName = true;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() => textControllerFirstName.text = value);
                        textFocusNodeFirstName.unfocus();
                        FocusScope.of(context).requestFocus(textFocusNodeLastName);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                        hintText: "First Name",
                        fillColor: Colors.white,
                        errorText: _isEditingFirstName
                            ? _validateFirstName(textControllerFirstName.text)
                            : null,


                        errorStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.redAccent,
                        ),
                      ),
                    )),

                Container(
                    margin: EdgeInsets.symmetric(vertical: 11, horizontal: 20),
                    child: TextField(
                      focusNode: textFocusNodeLastName,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: textControllerLastName,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          _isEditingLastName = true;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() => textControllerLastName.text = value);
                        textFocusNodeLastName.unfocus();
                        FocusScope.of(context).requestFocus(textFocusNodeAddress);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'First Name',
                        hintText: "First Name",
                        fillColor: Colors.white,
                        errorText: _isEditingLastName
                            ? _validateLastName(textControllerLastName.text)
                            : null,


                        errorStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.redAccent,
                        ),
                      ),
                    )),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 11, horizontal: 20),
                    child: TextField(
                      focusNode: textFocusNodeAddress,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      controller: textControllerAddress,
                      autofocus: false,
                      onChanged: (value) {
                        setState(() {
                          _isEditingAddress = true;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() => textControllerAddress.text = value);
                        textFocusNodeAddress.unfocus();
                        FocusScope.of(context).requestFocus(textFocusNodeEmail);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                        hintText: "Address",
                        fillColor: Colors.white,
                        errorText: _isEditingAddress
                            ? _validateAddress(textControllerAddress.text)
                            : null,


                        errorStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.redAccent,
                        ),
                      ),
                    )),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 11, horizontal: 20),
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
                        setState(() => textControllerEmail.text = value);
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
                    margin: EdgeInsets.symmetric(vertical: 11, horizontal: 20),
                    child: TextField(
                      focusNode: textFocusNodePassword,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      controller: textControllerPassword,
                      autofocus: false,
                      onChanged: (value) {
                        setState(() {
                          _isEditingPassword = true;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() => textControllerPassword.text = value);
                        textFocusNodePassword.unfocus();
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
                    margin: EdgeInsets.symmetric(vertical: 11, horizontal: 20),
                    child: TextField(
                      focusNode: textFocusNodeConfirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      controller: textControllerConfirmPassword,
                      autofocus: false,
                      onChanged: (value) {
                        setState(() {
                          _isEditingConfirmPassword = true;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() => textControllerConfirmPassword.text = value);
                        textFocusNodeConfirmPassword.unfocus();
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
                        errorText: _isEditingConfirmPassword
                            ? _validateConfirmPassword(textControllerConfirmPassword.text)
                            : null,


                        errorStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.redAccent,
                        ),
                      ),
                    )),

                    Container(
                       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                       child: TextField(
                         focusNode: textFocusNodePhone,
                         keyboardType: TextInputType.phone,
                         textInputAction: TextInputAction.next,
                         controller: textControllerPhone,
                         maxLength: 10,
                         maxLengthEnforced: true,
                         autofocus: false,
                         onChanged: (value) {
                           setState(() {
                             _isEditingPhone = true;
                           });
                         },
                         onSubmitted: (value) {
                           setState(() => textControllerPhone.text = value);
                           textFocusNodePhone.unfocus();

                         },
                         decoration: InputDecoration(
                           border: OutlineInputBorder(),
                           labelText: 'Phone Number',
                           hintText: "Phone Number",
                           fillColor: Colors.white,
                           prefix: Padding(
                             padding: EdgeInsets.all(4),
                             child: Text('+92'),
                           ),
                           errorText: _isEditingPhone
                               ? _validatePhone(textControllerPhone.text)
                               : null,


                           errorStyle: TextStyle(
                             fontSize: 12,
                             color: Colors.redAccent,
                           ),
                         ),
                       )

               ),

                Container(
                  width: 50.w,
                  height: 5.h,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                 child:  ElevatedButton(

                   style: ElevatedButton.styleFrom(
                     primary: Colors.red,
                   ),
                   child: Text('Sign Up',style: TextStyle(fontSize: 14.sp),),
                   onPressed: () {

                     print('ashdjas ${_checkEmailExist}');
                     print('fsjkdfhd ${_checkPhoneExist}');
                     print('ashdjas ${_checkEmailExist}');
                     print('fsjkdfhd ${_checkPhoneExist}');
                     print('ashdjas ${_checkEmailExist}');
                     print('fsjkdfhd ${_checkPhoneExist}');
                     getCurrentDate();

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
            ),],
          )
      ),
    );
  }

  RegiterAlert(BuildContext context) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Text('incorrect email or The email address is already in use by another account.'
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
  ValidateAlert(BuildContext context) async{
    if(textControllerFirstName.text.isEmpty || textControllerAddress.text.isEmpty || textControllerPassword.text.isEmpty || textControllerConfirmPassword.text.isEmpty || textControllerEmail.text.isEmpty || textControllerPhone.text.isEmpty)
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
    else if(textControllerPassword.text != textControllerConfirmPassword.text)
    {

      final snackBar1 = SnackBar(

        content: Text('please Enter correct password'),
        action: SnackBarAction(

          label: 'ok',

          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
    }

    else {
      _SignUp(textControllerEmail.text,textControllerPassword.text,textControllerFirstName.text,textControllerLastName.text, textControllerAddress.text ,textControllerPhone.text,finalDate, context);
    }


  }
}
