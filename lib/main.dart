import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:game_app/Model/Providers/Auth_Password_Edit.dart';
import 'package:game_app/Model/Providers/auth_services_Provider.dart';
import 'package:game_app/views/Screens/Editphone.dart';
import 'package:game_app/views/Screens/Home.dart';
import 'package:game_app/views/Screens/HomePage.dart';
import 'package:game_app/views/Screens/Setting.dart';
import 'package:game_app/views/Screens/login.dart';
import 'package:game_app/views/Screens/signup.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email =   prefs.getString('email');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  print(email);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => auth_Services_Provider()),
        ChangeNotifierProvider(create: (_) => Auth_Password_Edit_Provider()),

      ],
      child: Sizer(
          builder: (context, orientation, screenType)
          {
            return  MaterialApp(

              debugShowCheckedModeBanner: false,
              home: email == null ? Login() : Home(),
            );
          }
      )
    ),);
}

class MyApp extends StatelessWidget {
  final email;

  const MyApp({Key key, this.email}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, screenType)
        {
          return  MaterialApp(

            debugShowCheckedModeBanner: false,
            home: email == null ? Home() : Login(),
          );
        }
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}