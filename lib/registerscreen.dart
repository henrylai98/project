import 'package:flutter/material.dart';
import 'package:comforrtzone2020/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

void main() => runApp(SignupPage());

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>
    with SingleTickerProviderStateMixin {
  double screenHeight;
  String urlRegister = "https://yhkywy.com/comfortzone/php/register_user.php";
  TextEditingController _nameEditingController = new TextEditingController();
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _phoneEditingController = new TextEditingController();
  TextEditingController _passEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
        child: Image.asset(
          "assets/register.jpg",
          fit: BoxFit.cover,
        ));
  }

  Widget lowerHalf(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: screenHeight / 3.5),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Card(
              elevation: 10,
              color: Colors.white,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Signup",
                            style: TextStyle(
                              color: Colors.brown,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        TextFormField(
                          controller: _nameEditingController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Enter UserName",
                            icon: Icon(Icons.person),
                          ),
                        ),
                        TextFormField(
                          controller: _phoneEditingController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Enter Phone Number",
                            icon: Icon(Icons.phone),
                          ),
                        ),
                        TextFormField(
                          controller: _emailEditingController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Enter Email",
                            icon: Icon(Icons.email),
                          ),
                        ),
                        TextFormField(
                          controller: _passEditingController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Enter Password",
                            icon: Icon(Icons.lock),
                          ),
                          obscureText: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                        ),
                        MaterialButton(
                          color: Colors.brown,
                          textColor: Colors.white,
                          child: Text("Register"),
                          onPressed: _onRegister,
                        )
                      ]))),
          SizedBox(
            height: 40.0,
          ),
          Column(
            children: <Widget>[
              Container(
                color: Colors.brown,
                padding: const EdgeInsets.fromLTRB(100, 0, 0, 10),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Comfort Zone',
                  style: TextStyle(
                      color: Colors.brown,
                      fontSize: 25.0,
                      fontFamily: "Poppins-Medium")),
            ],
          ),
        ],
      ),
    );
  }

  void _onRegister() {
    String name = _nameEditingController.text;
    String email = _emailEditingController.text;
    String phone = _phoneEditingController.text;
    String password = _passEditingController.text;
    
    http.post(urlRegister, body: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    }).then((res) {
      if (res.body == "success") {
        Navigator.pop(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
        Toast.show("Register success", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Register fail", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }).catchError((err) {
      print(err);
    });
  }

  void loginScreen() {
    Navigator.pop(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }

 
  
}
