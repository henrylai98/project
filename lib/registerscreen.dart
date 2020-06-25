import 'package:flutter/material.dart';
import 'package:comforrtzone2020/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

void main() => runApp(SignupPage());

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  double screenHeight;
  bool _isChecked = false;
  String urlRegister = "https://yhkywy.com/comfortzone/php/register_user.php";
  TextEditingController _nameEditingController = new TextEditingController();
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _passEditingController = new TextEditingController();
  TextEditingController _phoneEditingController = new TextEditingController();

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
                            labelText: "Enter Username",
                            icon: Icon(Icons.person),
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
                        TextFormField(
                          controller: _phoneEditingController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Enter Phone Number",
                            icon: Icon(Icons.phone),
                          ),
                        ),
                        SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool value) {
                          _onChange(value);
                        },
                      ),
                      GestureDetector(
                        onTap: _showEULA,
                        child: Text('I Agree to Terms  ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold,color: Colors.brown)),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 115,
                        height: 50,
                        child: Text('Register'),
                        color: Color.fromRGBO(101, 255, 218, 50),
                        textColor: Colors.black,
                        elevation: 10,
                        onPressed: _onRegister,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Already register? ", style: TextStyle(fontSize: 16.0,color: Colors.brown)),
              GestureDetector(
                onTap: _loginScreen,
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.brown),
                ),
              ),
            ],
          )
           ],
      ),
    );
  }           
          

  void _onRegister() {
    String username = _nameEditingController.text;
    String email = _emailEditingController.text;
    String password = _passEditingController.text;
    String phonenumber = _phoneEditingController.text;
    if (!_isChecked) {
      Toast.show("Please Accept Term", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return;
    }
    
    http.post(urlRegister, body: {
      "username": username,
      "email": email,
      "password": password,
      "phonenumber": phonenumber,
    }).then((res) {
      if (res.body == "success") {
        Navigator.pop(
      context,
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

  void _loginScreen() {
    Navigator.pop(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }
   void _onChange(bool value) {
    setState(() {
      _isChecked = value;
      //savepref(value);
    });
  }

    void _showEULA() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("EULA"),
          content: new Container(
            height: screenHeight / 2,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new SingleChildScrollView(
                    child: RichText(
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              //fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                            text:
                                "This End-User License Agreement is a legal agreement between you and Slumberjer This EULA agreement governs your acquisition and use of our MY.GROCERY software (Software) directly from Slumberjer or indirectly through a Slumberjer authorized reseller or distributor (a Reseller).Please read this EULA agreement carefully before completing the installation process and using the MY.GROCERY software. It provides a license to use the MY.GROCERY software and contains warranty information and liability disclaimers. If you register for a free trial of the MY.GROCERY software, this EULA agreement will also govern that trial. By clicking accept or installing and/or using the MY.GROCERY software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement. If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.This EULA agreement shall apply only to the Software supplied by Slumberjer herewith regardless of whether other software is referred to or described herein. The terms also apply to any Slumberjer updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply. This EULA was created by EULA Template for MY.GROCERY. Slumberjer shall at all times retain ownership of the Software as originally downloaded by you and all subsequent downloads of the Software by you. The Software (and the copyright, and other intellectual property rights of whatever nature in the Software, including any modifications made thereto) are and shall remain the property of Slumberjer. Slumberjer reserves the right to grant licences to use the Software to third parties"
                            //children: getSpan(),
                            )),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
