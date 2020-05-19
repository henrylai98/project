import 'dart:async';
import 'package:comforrtzone2020/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:comforrtzone2020/registerscreen.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:comforrtzone2020/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp());
bool rememberMe = false;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
  }
  
  class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{ 
    double screenHeight;
    TextEditingController emailEditingController = new TextEditingController();
    TextEditingController passEditingController = new TextEditingController();
    AnimationController _iconAnimationController;
    Animation<double> _iconAnimation;
    String urlLogin = "http://yhkywy.com/comfortzone/php/login_user.php";


    @override
    void initState(){
      super.initState();
      _iconAnimationController = new AnimationController(
        vsync: this,
        duration:  new Duration(milliseconds: 500)
      );
      _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.easeOut
      );
      _iconAnimation.addListener(()=> this.setState((){}));
      _iconAnimationController.forward();
    }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Stack(
            children: <Widget>[
              upperHalf(context),
              lowerHalf(context),
              
            ],
          ));
  
  }

  
  Widget upperHalf(BuildContext context) {
    return Container(
      height: screenHeight / 2,
      child: Image.asset("assets/loginhouse.jpg",
        fit: BoxFit.cover,  
     ) );}
    
  Widget lowerHalf(BuildContext context) {   
      return Container(
          height: screenHeight / 2,
      margin: EdgeInsets.only(top: screenHeight / 3),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
            Card(
              elevation: 10,  
                child:  Container(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                  ),
                    TextFormField(
                      controller: emailEditingController,
                       keyboardType: TextInputType.emailAddress,
                       decoration: InputDecoration(
                         labelText: "Enter Email", 
                         ),
                         ),
                     TextFormField(
                      controller: passEditingController,
                      keyboardType: TextInputType.visiblePassword,
                       decoration:  InputDecoration(
                         labelText: "Enter Password",
                        ),
                         
                         obscureText: true, 
                         ),
                     Padding(padding: const EdgeInsets.only(top:20.0),
                    ),
                    MaterialButton(
                      color: Colors.teal,
                      textColor: Colors.white,
                      child: Text("Login"),
                      onPressed: this._userLogin,
                    )
                  ]
                )
                )),
                SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Don't have an account? ", style: TextStyle(fontSize: 16.0)),
              GestureDetector(
                onTap: _registerUser,
                child: Text(
                  "Create Account",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
                    SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to Spotify ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                       fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            )
          ]
         )
      );
     }
     void _userLogin() async {
    try {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Log in...");
      pr.show();
      String email = emailEditingController.text;
      String password = passEditingController.text;
      http
          .post(urlLogin, body: {
            "email": email,
            "password": password,
          })
          //.timeout(const Duration(seconds: 4))
          .then((res) {
            print(res.body);
            var string = res.body;
            List userdata = string.split(",");
            if (userdata[0] == "success") {
              User _user = new User(
                  name: userdata[1],
                  email: email,
                  password: password,
                  phone: userdata[4],
                  );
              pr.hide().then((isHidden){
                print(isHidden);
              });
              Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainPage(
                        user: _user,
                  )));
            } else {
              pr.hide().then((isHidden){
                print(isHidden);
              });
              Toast.show("Login failed", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            }
          })
          .catchError((err) {
            print(err);
            pr.hide().then((isHidden){
                print(isHidden);
              });
          });
    } on Exception  catch (_) {
      Toast.show("Error", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Future<void> loadPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String email =(sharedPreferences.getString('email'))??'';
    String password =(sharedPreferences.getString('password'))??'';
    if (email.length > 1){
      setState(() {
        emailEditingController.text=email;
        passEditingController.text=password;
      });
        
    }
  }

     void _registerUser() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => SignupPage()));
  }
  }