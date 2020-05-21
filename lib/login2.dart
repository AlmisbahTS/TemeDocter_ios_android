import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:teme_doctor/DashBord.dart';
import 'package:teme_doctor/forgotpass.dart';
import 'package:teme_doctor/pending.dart';
import 'package:teme_doctor/signup.dart';

class Login2 extends StatefulWidget {
  @override
  _Login2State createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  bool _isloading = false;
  String _email, _password;
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
                          "Login",
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
                          height: 20,
                        ),
                        TextFormField(
                          validator: (input) {
                            if (input.length < 6) {
                              return 'Password should be atleast 6 digit';
                            }
                            return null;
                          },
                          onSaved: (input) {
                            _password = input;
                          },
                          obscureText: true,
                          // controller: titleController,
                          decoration: InputDecoration(
                            filled: true,
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(171, 31, 94, 1),
                            ),
                            // prefixIcon: new Icon(Icons.search, color: Colors.black),
                            hintText: "Password",
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),

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
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ForgotPass()));
                              },
                              child: Text("Forgot Password ?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(171, 31, 94, 1),
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
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
                                  signIn();
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ChatScreen()));
                                },
                                child: Text("Login")),
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

  Future signIn() async {
    final formState = _formKey.currentState;
    
    
    if (formState.validate()) {
      formState.save();
      setState(() {
        _isloading = true;
      });
      try {

        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password)
            .then((currentDoctor) {
              // String doctorid=currentDoctor.user.uid.toString();
              return Firestore.instance
                    .collection("doctors")
                    .document(currentDoctor.user.uid)
                    .get()
                    .then((DocumentSnapshot result) {
                  if (result.data == null) {
                    FirebaseAuth.instance.signOut().then((logout) {
                      message = "Please Login From A Doctor Account";
                      setState(() {
                        _isloading = false;
                      });
                    });
                  } else if (result["Status"] == "Pending") {
                    setState(() {
                      _isloading = false;
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => PendingPage()));
                    });
                  } else if(result["Status"] == "Confirmed"){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => DashBoard(result)));
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => ChatScreen()));
                  }
                  else{
                    
                  }
                });
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
}
