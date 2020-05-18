import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:teme/home.dart';
// import 'package:teme/pages/feature.dart';
// import 'package:teme/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:teme_doctor/login2.dart';
import 'package:teme_doctor/signup.dart';

class ForgotPass extends StatefulWidget {
  @override
  ForgotPassState createState() => ForgotPassState();
}

class ForgotPassState extends State<ForgotPass> {
  bool _isloading = false;
  String _email;
  String message = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/splashscreen.png"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
              SizedBox(
                height: 70,
              ),
              Container(
                // height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Forgot Password",
                          style: TextStyle(
                              color: Color.fromRGBO(171, 31, 95, 1),
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          message,
                          style: TextStyle(color: Colors.red),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (input) {
                            RegExp regexp = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            if (!regexp.hasMatch(input)) {
                              return 'Please type an Email';
                            }
                            return null;
                          },
                          onSaved: (input) {
                            _email = input;
                          },
                          // controller: titleController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(171, 31, 94, 1),
                                style: BorderStyle.solid,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(171, 31, 94, 1),
                              ),
                            ),
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(171, 31, 94, 1),
                            ),
                            filled: true,
                            // prefixIcon: new Icon(Icons.search, color: Colors.black),
                            hintText: "Email",
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _isloading
                            ? Center(
                                child: CircularProgressIndicator(
                                  backgroundColor:
                                      Color.fromRGBO(171, 31, 95, 1),
                                ),
                              )
                            : RaisedButton(
                                textColor: Colors.white,
                                color: Color.fromRGBO(171, 31, 94, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                onPressed: () {
                                  recoverypassword();
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ChatScreen()));
                                },
                                child: Text("Recover Now")),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Need a New Account ",
                                style: TextStyle(color: Colors.grey)),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: Text("Click Here",
                                  style: TextStyle(
                                      color: Color.fromRGBO(171, 31, 94, 1),
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future recoverypassword() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      setState(() {
        _isloading = true;
      });
      try {

        await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return emailsent();
            });
        setState(() {
          message="";
          _isloading = false;
         
        });
      } catch (e) {
        setState(() {
          _isloading = false;
          message = e.message;
        });

        print(e.message);
      }
    }
  }

  emailsent() {
    return AlertDialog(
      content: Container(
        height: 250,
        child: Column(
          children: <Widget>[
            Container(
              height: 75,
              decoration: BoxDecoration(
                  // color: Colors.green,
                  image: DecorationImage(
                image: AssetImage("images/yes.png"),
              )),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              """Your account recovery Email sent To your email. Please Check email and reset password""",
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                textColor: Colors.white,
                color: Color.fromRGBO(171, 31, 94, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                onPressed: () {
                  // signIn();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login2()));
                },
                child: Text("Ok")),
          ],
        ),
      ),
    );
  }
}
