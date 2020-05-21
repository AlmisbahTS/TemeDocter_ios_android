import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teme_doctor/DashBord.dart';
import 'package:teme_doctor/login2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/login.dart';
import 'package:teme_doctor/pending.dart';


// import 'package:teme/home.dart';
// import 'package:teme/pages/feature.dart';
class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/splashscreen.png"),
                fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            //NOTE -This is Teme *Logo* splash screen
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100.0),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("images/teme_name.png"),
                  )),
                  height: 100,
                ),
              ),
            ),
            //NOTE -This is Teme Text On splash screen
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  child: RaisedButton(
                      textColor: Color.fromRGBO(171, 31, 94, 1),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      onPressed: () {
//                        Navigator.pushReplacement(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => SignUpStep2()));
//
                        signout();
                        Login(
                          loggedIn: signin2(),
                          loggedOut: signout(),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 18),
                      )),
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Padding(
            //     padding: const EdgeInsets.only(bottom: 20.0),
            //     child: Container(
            //       child: RaisedButton(
            //           textColor: Color.fromRGBO(171, 31, 94, 1),
            //           color: Colors.white,
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(100)),
            //           onPressed: () {
            //             Navigator.push(context,
            //                 MaterialPageRoute(builder: (context) => SignUp()));
            //           },
            //           child: Text(
            //             "Sign Up",
            //             style: TextStyle(fontSize: 18),
            //           )),
            //       height: 60,
            //       width: MediaQuery.of(context).size.width * 0.9,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  signin2() {
    signIn();
  }

  signout() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login2()));
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.currentUser().then((currentuser) {
        //
        return Firestore.instance
            .collection("doctors")
            .document(currentuser.uid)
            .get()
            .then((DocumentSnapshot result) {
          if (result["Status"] == "Pending") {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => PendingPage()));
          } else if (result["Status"] == "Confirmed") {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => DashBoard(result)));
          } else {
            //    Navigator.pushReplacement(context,
            // MaterialPageRoute(builder: (context) => Login2()));
          }

          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => ChatScreen()));
        });
////
      });
    } catch (e) {
      // Navigator.pushReplacement(context,
      //         MaterialPageRoute(builder: (context) => Login2()));
      // setState(() {
      //   // print(e.message);
      // });

      print(e);
    }
  }
}
