// import 'package:camera/camera.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teme_doctor/login2.dart';
import 'package:teme_doctor/pending.dart';

class SignUp extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignUp> {
  double spaceBWtxtfield = 10;
  File _imgageSelfi;
  File _imagesCNIC;
  String message = "";
  bool terms = true;
  bool isblacklist = false;
  bool isgovtJob = false;
  bool isPartjob = false;
  bool isqualified = true;
  bool _isloading = false;
  var _email,
      _phoneNumber,
      _fullname,
      _registrationNO,
      _registrationYear,
      _password;
  int gender = 0;

  var _stateMedicalCouncil = "BOP";
  var _specialtyValue="Brain";

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  SizedBox(width: 25)
                ],
              ),
              SizedBox(
                height: 10,
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
                          "Register To TEME DOC",
                          style: TextStyle(
                            fontSize: 22,
                            color: Color.fromRGBO(171, 31, 95, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
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
                          decoration: deco("Email"),
                        ),
                        SizedBox(
                          height: spaceBWtxtfield,
                        ),
                        TextFormField(
                          validator: (input) {
                            if (input.length < 3) {
                              return 'Full Name Should be atleast 4 chracter';
                            }
                            return null;
                          },
                          onSaved: (input) {
                            _fullname = input;
                          },
                          // controller: titleController,
                          decoration: deco("Full Name"),
                        ),
                        SizedBox(
                          height: spaceBWtxtfield,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (input) {
                            if (input.length < 11) {
                              return 'Enter 11 digit phone number';
                            }
                            return null;
                          },
                          onSaved: (input) {
                            _phoneNumber = input;
                          },
                          // obscureText: true,
                          // controller: titleController,
                          decoration: deco("Phone Number"),
                        ),
                        SizedBox(
                          height: spaceBWtxtfield,
                        ),
                        TextFormField(
                          validator: (input) {
                            if (input.length < 2) {
                              return 'Registration Number is Necessory';
                            }
                            return null;
                          },
                          onSaved: (input) {
                            _registrationNO = input;
                          },
                          // obscureText: true,
                          // controller: titleController,
                          decoration: deco("Registration Number"),
                        ),
                        SizedBox(
                          height: spaceBWtxtfield,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (input) {
                            if (input.length != 4) {
                              return 'Enter Registration year eg. 2019';
                            }
                            return null;
                          },
                          onSaved: (input) {
                            _registrationYear = input;
                          },
                          // obscureText: true,
                          // controller: titleController,
                          decoration: deco("Registration Year"),
                        ),
                        SizedBox(
                          height: spaceBWtxtfield,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Gender:",
                              style: TextStyle(
                                color: Color.fromRGBO(171, 31, 94, 1),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Radio(
                                  activeColor: Color.fromRGBO(171, 31, 94, 1),
                                  value: 0,
                                  groupValue: gender,
                                  onChanged: (val) {
                                    setState(() {
                                      gender = val;
                                    });
                                  },
                                ),
                                Text(
                                  "Male",
                                  style: TextStyle(
                                    color: Color.fromRGBO(171, 31, 94, 1),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Radio(
                                  activeColor: Color.fromRGBO(171, 31, 94, 1),
                                  value: 1,
                                  groupValue: gender,
                                  onChanged: (val) {
                                    setState(() {
                                      gender = val;
                                    });
                                  },
                                ),
                                Text(
                                  "Female",
                                  style: TextStyle(
                                    color: Color.fromRGBO(171, 31, 94, 1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: spaceBWtxtfield,
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
                                    "State Medical Council",
                                    style: TextStyle(
                                        color: Color.fromRGBO(171, 31, 94, 1),
                                        fontSize: 16),
                                  ),
                                ),
                                DropdownButton(
                                    icon: Icon(
                                      Icons.arrow_drop_down_circle,
                                      color: Color.fromRGBO(171, 31, 94, 1),
                                    ),
                                    value: _stateMedicalCouncil,
                                    items: [
                                      DropdownMenuItem(
                                          value: "BOP",
                                          child: Text(
                                            "BOP",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  171, 31, 94, 1),
                                            ),
                                          )),
                                      DropdownMenuItem(
                                          value: "FFNCS",
                                          child: Text(
                                            "FFNCS",
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  171, 31, 94, 1),
                                            ),
                                          )),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _stateMedicalCouncil = value;
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: spaceBWtxtfield,
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
                                    "Select Specialty",
                                    style: TextStyle(
                                        color: Color.fromRGBO(171, 31, 94, 1),
                                        fontSize: 16),
                                  ),
                                ),

                                //
                                StreamBuilder<QuerySnapshot>(
                                    stream: Firestore.instance
                                        .collection('specialty')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Text("Loading");
                                      } else {
                                        List<DropdownMenuItem> specialty = [];
                                        for (int i = 0;
                                            i < snapshot.data.documents.length;
                                            i++) {
                                          DocumentSnapshot snap =
                                              snapshot.data.documents[i];
                                          specialty.add(DropdownMenuItem(
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
                                                value: _specialtyValue,
                                                icon: Icon(
                                                  Icons.arrow_drop_down_circle,
                                                  color: Color.fromRGBO(
                                                      171, 31, 94, 1),
                                                ),
                                                items: specialty,
                                                onChanged: (specialtyValue) {
                                                  setState(() {
                                                    _specialtyValue =
                                                        specialtyValue;
                                                  });
                                                }));
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: spaceBWtxtfield,
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
                                Text(
                                  "Select Profile Picture",
                                  style: TextStyle(
                                      color: Color.fromRGBO(171, 31, 94, 1),
                                      fontSize: 16),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      // image: Image(image: _imgageSelfi)
                                      ),
                                  width: 50,
                                  child: _imgageSelfi == null
                                      ? null
                                      : Image.file(_imgageSelfi),
                                ),
                                InkWell(
                                    onTap: () {
                                      return takeselfie();
                                    },
                                    child: Icon(
                                      Icons.camera,
                                      color: Color.fromRGBO(171, 31, 94, 1),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: spaceBWtxtfield,
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
                                Text(
                                  "Select CNIC Picture",
                                  style: TextStyle(
                                      color: Color.fromRGBO(171, 31, 94, 1),
                                      fontSize: 16),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      // image: Image(image: _imgageSelfi)
                                      ),
                                  width: 50,
                                  // color: Colors.red,
                                  child: _imagesCNIC == null
                                      ? null
                                      : Image.file(_imagesCNIC),
                                ),
                                InkWell(
                                    onTap: () {
                                      return takecnic();
                                    },
                                    child: Icon(
                                      Icons.photo_camera,
                                      color: Color.fromRGBO(171, 31, 94, 1),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: spaceBWtxtfield,
                        ),
                        TextFormField(
                          validator: (input) {
                            if (input.length < 6) {
                              return 'Password should be atleast 6 digits';
                            }
                            return null;
                          },
                          onSaved: (input) {
                            _password = input;
                          },
                          obscureText: true,

                          // controller: titleController,
                          decoration: deco("Password"),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Checkbox(
                                activeColor: Color.fromRGBO(171, 31, 94, 1),
                                value: isqualified,
                                onChanged: (bool value) {
                                  setState(() {
                                    isqualified = value;
                                  });
                                }),
                            Text("Are You Qualified Doctor ",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Checkbox(
                                activeColor: Color.fromRGBO(171, 31, 94, 1),
                                value: isPartjob,
                                onChanged: (bool value) {
                                  setState(() {
                                    isPartjob = value;
                                  });
                                }),
                            Text("Are You Intrested in Part Time Job?",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Checkbox(
                                activeColor: Color.fromRGBO(171, 31, 94, 1),
                                value: isgovtJob,
                                onChanged: (bool value) {
                                  setState(() {
                                    isgovtJob = value;
                                  });
                                }),
                            Text("Are You Government Doctor?",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Checkbox(
                                activeColor: Color.fromRGBO(171, 31, 94, 1),
                                value: isblacklist,
                                onChanged: (bool value) {
                                  setState(() {
                                    isblacklist = value;
                                  });
                                }),
                            Text("Are You Black Listed Doctor?",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Checkbox(
                                activeColor: Color.fromRGBO(171, 31, 94, 1),
                                value: terms,
                                onChanged: (bool value) {
                                  setState(() {
                                    terms = value;
                                  });
                                }),
                            Text("Agree with Terms & Conditions ? ",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return conditionPopUp();
                                    });
                              },
                              child: Text("View",
                                  style: TextStyle(
                                      color: Color.fromRGBO(171, 31, 94, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            )
                          ],
                        ),
                        Text(message, style: TextStyle(color: Colors.red)),
                        SizedBox(
                          height: 5,
                        ),
                        _isloading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : RaisedButton(
                                textColor: Colors.white,
                                color: Color.fromRGBO(171, 31, 94, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () {
                                  if (terms == false ||
                                      _imgageSelfi == null ||
                                      _imagesCNIC == null ||
                                      _specialtyValue == null) {
                                    setState(() {
                                      message =
                                          "Please Upload CNIC and Selfi And Check on Term & Conditions";
                                    });
                                  } else if (_formKey.currentState.validate()) {
                                    signUp(context);
                                  }
                                },
                                child: Text("Register")),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Already Account ? ",
                                style: TextStyle(color: Colors.grey)),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login2()));
                              },
                              child: Text("Login Here",
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

  deco(String labeltext) {
    return InputDecoration(
      labelText: "$labeltext",
      labelStyle: TextStyle(
        color: Color.fromRGBO(171, 31, 94, 1),
      ),

      filled: true,
      // prefixIcon: new Icon(Icons.search, color: Colors.black),
      hintText: "$labeltext",
      fillColor: Colors.white,
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromRGBO(171, 31, 94, 1),
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Color.fromRGBO(171, 31, 94, 1),
        ),
      ),
    );
  }

  uploadImage(File image) async {
    StorageReference reference =
        FirebaseStorage.instance.ref().child(image.path.toString());
    StorageUploadTask uploadTask = reference.putFile(image);

    StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);

    String urlSelfi = (await downloadUrl.ref.getDownloadURL());

    return urlSelfi;
  }
  
  Future signUp(context) async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      setState(() {
        _isloading = true;
      });
      formState.save();
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password)
            .then((currentDoctor) async {
          var urlSelfi = await uploadImage(_imgageSelfi);
          var urlCNIC = await uploadImage(_imagesCNIC);
          if (urlSelfi != null) {
            return Firestore.instance
                .collection("doctors")
                .document(currentDoctor.user.uid)
                .setData({
              "DoctorID": currentDoctor.user.uid,
              "Email": _email,
              "DoctorName": _fullname,
              "PhoneNumber": _phoneNumber,
              "Gender": gender,
              "RegistrationNO": _registrationNO,
              "RegistrationYear": _registrationYear,
              "StateMedical": _stateMedicalCouncil,
              "isQualified": isqualified,
              "ispartjob": isPartjob,
              "isGovtJob": isgovtJob,
              "isBlackList": isblacklist,
              "Status": "Pending",
              "urlSelfi": urlSelfi,
              "urlCNIC": urlCNIC,
              "Specialty": _specialtyValue
            });
          }
        }).then((sec) async {
          await Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => PendingPage()));
        });

        // uploadImage(_imgageSelfi);

      }

      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Login(), fullscreenDialog: true));

      catch (e) {
        setState(() {
          message = e.message;
          _isloading = false;
        });

        print(e.message);
      }
    }
  }

  conditionPopUp() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here

      content: (Container(
        // color: Colors.red,
        height: 300,
        child: ListView(
          children: <Widget>[
            Wrap(
              children: <Widget>[
                Text(
                    "By creating a TEME account , You are agreeing to be bound by the terms of use.",
                    style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(112, 112, 112, 1),
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Wrap(
              children: <Widget>[
                Text(
                    """"You are also agreeing to how Services TEME collects,uses and discloses your personal information , as set out in the privacy notice.""",
                    style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(112, 112, 112, 1),
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Wrap(
              children: <Widget>[
                Text(
                    "The term set out your responsibility as a TEME account holder and our responsibilities as the service provider of TEME",
                    style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(112, 112, 112, 1),
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Wrap(
              children: <Widget>[
                Text(
                    "By clicking 'I Agree' this mean you have read and understand the full terms of use and agree to comply with them.",
                    style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(112, 112, 112, 1),
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        textColor: Colors.white,
                        color: Color.fromRGBO(171, 31, 94, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("OK")),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
          ],
        ),
      )),
    );
  }

  void takeselfie() async {
    var selfi = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imgageSelfi = selfi;
    });
  }

  void takecnic() async {
    var cnic = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imagesCNIC = cnic;
    });
  }
}
