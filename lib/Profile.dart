import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_icons/flutter_icons.dart';
// import 'package:feathers/feathers.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Profile extends StatefulWidget {
  Profile(this.doctorData);
  final doctorData;
  @override
  _ProfileState createState() => _ProfileState(doctorData);
}

class _ProfileState extends State<Profile> {
  _ProfileState(this.doctorData);
  final doctorData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(171, 31, 94, 1),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                width: double.infinity,
                // height: 200,
                padding: EdgeInsets.all(16.0),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        margin: EdgeInsets.only(left: 16.0),
                        child: CircleAvatar(

                            // radius: 20.0,
                            backgroundImage:
                                NetworkImage(doctorData["urlSelfi"]))),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          doctorData["DoctorName"],
                          // style: Theme.of(context).textTheme.title,
                        ),
                        Text(doctorData['Degree']),
                        Text(
                            "Registration Year ${doctorData['RegistrationYear']}"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                // padding: EdgeInsets.all(16.0),
                // margin: EdgeInsets.only(top: 16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0)),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("User Information"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Email"),
                      subtitle: Text(doctorData["Email"]),
                      leading: Icon(
                        Feather.getIconData("mail"),
                      ),
                    ),
                    ListTile(
                      title: Text("Phone Number"),
                      subtitle: Text(doctorData["PhoneNumber"]),
                      leading: Icon(
                        Feather.getIconData("phone"),
                      ),
                    ),
                    ListTile(
                      title: Text("State Medical Council:"),
                      subtitle: Text(" ${doctorData['StateMedical']}"),
                      leading: Icon(
                        Feather.getIconData("globe"),
                      ),
                    ),
                    ListTile(
                      title: Text("Registration No."),
                      subtitle: Text(doctorData['RegistrationNO']),
                      leading: Icon(
                        Feather.getIconData("info"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
