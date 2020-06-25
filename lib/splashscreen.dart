import 'package:comforrtzone2020/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:comforrtzone2020/loginscreen.dart';

 
void main() => runApp(MyApp());


class MyApp extends StatefulWidget{
  @override 
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primarySwatch: Colors.brown,),
      title: 'Material App',
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.white)
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               Container(
                   height: 150.0,
                   decoration: BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage('assets/logocs.jpg'),      
                  )   
                 )
                ),
              ]
            ),
            Container(height: 300, child: ProgressIndicator())
          ],
        )
        ),
      );
  }
}
class ProgressIndicator extends StatefulWidget {
  @override
  _ProgressIndicatorState createState() => new _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          //updating states
          if (animation.value > 0.99) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()));
          }
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
      //width: 300,
      child: CircularProgressIndicator(
        value: animation.value,
        //backgroundColor: Colors.brown,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    ));
  }}