import 'package:flutter/material.dart';
import 'package:game_app/views/Screens/AppDrawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BINGO'),backgroundColor: Colors.red,
      ),
      drawer: AppDrawer(),
    );
  }
}
