import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'StepThree.dart';

class SignUpStep2 extends StatefulWidget {
  @override
  _SignupState2 createState() => _SignupState2();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _SignupState2 extends State<SignUpStep2> {
  var _value;
  var _specialtyValue;
  bool selectD = false;
  List<DropdownMenuItem> spList = [
    //////////////////////
    //////////////////////
//    DropdownMenuItem(
//        value: "FFNCS",
//        child: Text(
//          "FFNCS",
//          style: TextStyle(
//            color: Color.fromRGBO(
//                171, 31, 94, 1),
//          ),
//        )),
  ];

  spStreem() {
    StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('degree').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          } else {
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              DocumentSnapshot snap = snapshot.data.documents[i];
              spList.add(DropdownMenuItem(
                child: Text(
                  "${snap['Degree']}",
                  style: TextStyle(
                    color: Color.fromRGBO(171, 31, 94, 1),
                  ),
                ),
                value: "${snap['Degree']}",
              ));
            }
          }
          return Container();
        });
  }

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
              SizedBox(
                height: 50,
              ),
              Container(
                // height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          style: TextStyle(
                            fontSize: 22,
                            color: Color.fromRGBO(171, 31, 95, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                color: Color.fromRGBO(171, 31, 94, 1),
                              )
                              // color: Colors.red
                              ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    "Postgraduate Degree",
                                    style: TextStyle(
                                        color: Color.fromRGBO(171, 31, 94, 1),
                                        fontSize: 16),
                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: Firestore.instance
                                        .collection('degree')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Text("Loading");
                                      } else {
                                        List<DropdownMenuItem> degree = [];
                                        for (int i = 0;
                                            i < snapshot.data.documents.length;
                                            i++) {
                                          DocumentSnapshot snap =
                                              snapshot.data.documents[i];
                                          degree.add(DropdownMenuItem(
                                            child: Text(
                                              "${snap['Degree']}",
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    171, 31, 94, 1),
                                              ),
                                            ),
                                            value: "${snap['Degree']}",
                                          ));
                                        }
                                        return Container(
                                            child: DropdownButton(
                                                value: _value,
                                                icon: Icon(
                                                  Icons.arrow_drop_down_circle,
                                                  color: Color.fromRGBO(
                                                      171, 31, 94, 1),
                                                ),
                                                items: degree,
                                                onChanged: (value) {
                                                  spStreem();
                                                  setState(() {
                                                    selectD = true;
                                                    _value = value;
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => StepThree(value)));

                                                  });
                                                }));
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
//                        selectD
//                            ?
//                            : Container(),
                        SizedBox(
                          height: 30,
                        ),
//                        FlatButton(
//                          textColor: Colors.white,
//                          color: Color.fromRGBO(171, 31, 94, 1),
//                          shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(50)),
//                          onPressed: () {},
//                          child: Text(
//                            "Register",
//                            style: TextStyle(fontSize: 15),
//                          ),
//                        ),
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
}
