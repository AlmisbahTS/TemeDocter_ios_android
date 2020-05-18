import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teme_doctor/login2.dart';

class PendingPage extends StatefulWidget {
  @override
  _PendingPageState createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/splashscreen.png"),
                fit: BoxFit.cover)),
                child:pending(),
      ),
    );
  }
  pending() {
    return AlertDialog(
      content: Container(
        height: 260,
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
              '''Your account created Successfully.Your information submitted to admin Awaiting for approval.''',
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
