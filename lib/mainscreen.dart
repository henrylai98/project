import 'package:flutter/material.dart';
import 'package:comforrtzone2020/registerscreen.dart';
import 'package:comforrtzone2020/splashscreen.dart';
import 'package:comforrtzone2020/loginscreen.dart';
import 'package:comforrtzone2020/user.dart';

void main() => runApp(MaterialApp());
 
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}