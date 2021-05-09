import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Auth_Password_Edit_Provider extends ChangeNotifier{
  Future <bool> ValidateCurrentPassword(String password) async
  {
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
}