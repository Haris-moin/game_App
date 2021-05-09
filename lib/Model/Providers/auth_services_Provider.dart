import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class auth_Services_Provider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool authSignedIn;
  String uid;
  String userEmail;
  String name;
  Future<String> registerWithEmailPassword(String email, String password, String Firstname,String Lastname,String address ,String phone, int Date) async {
    // Initialize Firebase

    final UserCredential userCredential =
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final User user = userCredential.user;

    if (user != null) {
      // checking if uid or email is null
      assert(user.uid != null);
      assert(user.email != null);

      uid = user.uid;
      userEmail = user.email;
      final QuerySnapshot result =
      await FirebaseFirestore.instance.collection('users').where('id', isEqualTo: user.uid).get();
      final List < DocumentSnapshot > documents = result.docs;
      if (documents.length == 0 && email!= null && Firstname != null && Lastname != null && address != null && phone!=null && password!=null) {
        // Update data to server if new user
        name= Firstname + ' ' +Lastname;
        FirebaseFirestore.instance.collection('users').doc(user.uid).set(
            { 'email': email, 'Name' : name, 'address' : address ,'phone': '+92${phone}', 'RegisterDate' : Date , 'id': user.uid });
      }
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', userEmail );
      return 'Successfully registered, User UID: ${user.uid}';


    }

    return null;
  }

  Future<String> signInWithEmailPassword(String email, String password) async {
    // Initialize Firebase

    final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final User user = userCredential.user;

    if (user != null) {
      // checking if uid or email is null
      assert(user.uid != null);
      assert(user.email != null);

      uid = user.uid;
      userEmail = user.email;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
      prefs.setString('email', userEmail );
      return 'Successfully logged in, User UID: ${user.uid}';
    }

    return null;
  }

// signOut Method

  Future<String> signOut() async {
    await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');

    uid = null;
    userEmail = null;

    return 'User signed out';
  }

}
