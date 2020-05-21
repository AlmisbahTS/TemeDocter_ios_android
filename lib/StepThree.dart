import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teme_doctor/RegisterNextStep.dart';


class StepThree extends StatefulWidget {
  StepThree(this.value);

  final value;

  @override
  _StepThreeState createState() => _StepThreeState(value);
}

class _StepThreeState extends State<StepThree> {
  var _value;

  _StepThreeState(this.value);

  final value;
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpStep2()));

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
                          "Choose Your Speciality",
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
                                    "Speciality",
                                    style: TextStyle(
                                        color: Color.fromRGBO(171, 31, 94, 1),
                                        fontSize: 16),
                                  ),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: Firestore.instance
                                        .collection('specialty')
                                        .where("Degree",isEqualTo: value)
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
                                              "${snap['Title']}",
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    171, 31, 94, 1),
                                              ),
                                            ),
                                            value: "${snap['Title']}",
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
                                                  setState(() {
                                                    _value = value;
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
                        FlatButton(
                          textColor: Colors.white,
                          color: Color.fromRGBO(171, 31, 94, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () {},
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 15),
                          ),
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
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Container(
//        height: MediaQuery.of(context).size.height,
//        decoration: BoxDecoration(
//            image: DecorationImage(
//                image: AssetImage("images/splashscreen.png"),
//                fit: BoxFit.cover)),
//        child: Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 10),
//          child: ListView(
//            children: <Widget>[
//              SizedBox(
//                height: 50,
//              ),
//              Container(
//                // height: 300,
//                decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(20),
//                  color: Colors.white,
//                ),
//                child: Form(
//                  key: _formKey,
//                  child: Padding(
//                    padding: const EdgeInsets.symmetric(
//                        horizontal: 15.0, vertical: 10),
//                    child: Column(
//                      children: <Widget>[
//                        SizedBox(
//                          height: 30,
//                        ),
//                        Text(
//                          "Choose Your Speciality",
//                          style: TextStyle(
//                            fontSize: 22,
//                            color: Color.fromRGBO(171, 31, 95, 1),
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                        SizedBox(
//                          height: 30,
//                        ),
//                        Container(
//                          height: 50,
//                          width: double.infinity,
//                          decoration: BoxDecoration(
//                              borderRadius:
//                              BorderRadius.all(Radius.circular(20)),
//                              border: Border.all(
//                                color: Color.fromRGBO(171, 31, 94, 1),
//                              )
//                            // color: Colors.red
//                          ),
//                          child: Padding(
//                            padding:
//                            const EdgeInsets.symmetric(horizontal: 20.0),
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              children: <Widget>[
//                                Flexible(
//                                  child: Text(
//                                    "Speciality",
//                                    style: TextStyle(
//                                        color: Color.fromRGBO(171, 31, 94, 1),
//                                        fontSize: 16),
//                                  ),
//                                ),
//                                StreamBuilder<QuerySnapshot>(
//                                    stream: Firestore.instance
//                                        .collection('specialty')
//                                    .where("Degree",isEqualTo: value)
//                                        .snapshots(),
//                                    builder: (context, snapshot) {
//                                      if (!snapshot.hasData) {
//                                        return Text("Loading");
//                                      } else {
//                                        List<DropdownMenuItem> degree = [];
//                                        for (int i = 0;
//                                        i < snapshot.data.documents.length;
//                                        i++) {
//                                          DocumentSnapshot snap =
//                                          snapshot.data.documents[i];
//                                          degree.add(DropdownMenuItem(
//                                            child: Text(
//                                              "${snap['Title']}",
//                                              style: TextStyle(
//                                                color: Color.fromRGBO(
//                                                    171, 31, 94, 1),
//                                              ),
//                                            ),
//                                            value: "${snap['Title']}",
//                                          ));
//                                        }
//                                        return Container(
//                                            child: DropdownButton(
//                                                value: _value,
//                                                icon: Icon(
//                                                  Icons.arrow_drop_down_circle,
//                                                  color: Color.fromRGBO(
//                                                      171, 31, 94, 1),
//                                                ),
//                                                items: degree,
//                                                onChanged: (value) {
//
//                                                  setState(() {
//
//                                                    _value = value;
//                                                    Navigator.pushReplacement(
//                                                        context,
//                                                        MaterialPageRoute(
//                                                            builder: (context) => StepThree(value)));
//
//                                                  });
//                                                }));
//                                      }
//                                    }),
//                              ],
//                            ),
//                          ),
//                        ),
//                        SizedBox(
//                          height: 30,
//                        ),
////                        selectD
////                            ?
////                            : Container(),
//                        SizedBox(
//                          height: 30,
//                        ),
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
//                        SizedBox(
//                          height: 10,
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
}
