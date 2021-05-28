import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:game_app/views/Screens/AppDrawer.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;


  FlutterLocalNotificationsPlugin flutterNotification;
  @override
  void initState(){
    notificationPermission();
    super.initState();

  }
  void getToken() async {
    print(await messaging.getToken());
  }


  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

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


  @override
  Widget build(BuildContext context) {
    getToken();
    return  WillPopScope(

        onWillPop:  () async {
          if (_key.currentState.isDrawerOpen) {
            
            Navigator.of(context).pop();
            return false;
          }
          else{

          return  _OnBackPrssed();

          }


        },
        child: Scaffold(
          key: _key,
          appBar: AppBar(
          title: Text('BINGO'),backgroundColor: Colors.red,
        ),
          drawer: AppDrawer(),
        body: Center(

        ),
        ),
    );
  }

  void initMesseging() {
    var androidInit = AndroidInitializationSettings('ic_launcher');
    var iosInit = IOSInitializationSettings();
    var initSetting = InitializationSettings(android: androidInit,iOS: iosInit);
    flutterNotification = FlutterLocalNotificationsPlugin();
    flutterNotification.initialize(initSetting);


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        showNotification();
      }
    });
  }

  void showNotification() async{
    var androidDetails = AndroidNotificationDetails(
      'channelId', 'channelName', 'channelDescription'
    );
    var iosDetails = IOSNotificationDetails();
    var generalNotification = NotificationDetails(android: androidDetails,iOS: iosDetails);

    await flutterNotification.show(0, 'title', 'body',generalNotification,payload: 'Notification');
  }

  void notificationPermission() async{
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

  }
}

