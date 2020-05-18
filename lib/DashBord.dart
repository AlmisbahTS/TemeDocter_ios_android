import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teme_doctor/Chat_screen.dart';
import 'package:teme_doctor/Profile.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teme_doctor/login2.dart';
import 'package:intl/intl.dart';

class DashBoard extends StatefulWidget {
  DashBoard(this.doctorid);
  final doctorid;
  @override
  _DashBoardState createState() => _DashBoardState(doctorid);
}

class _DashBoardState extends State<DashBoard> {
  bool unread = true;

  _DashBoardState(this.doctorid);
  final doctorid;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashBoard(doctorid)));
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Feather.getIconData("log-out"),
            ),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              FirebaseAuth.instance.signOut();
              return Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login2()));
            },
          ),
          centerTitle: true,
          title: Text(
            'Chats',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          elevation: 0.0,
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile(doctorid)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: CircleAvatar(

                        // radius: 20.0,
                        backgroundImage: NetworkImage(doctorid["urlSelfi"]))),
              ),
            ),
          ],
        ),
        body: Container(
          // height: 500.0,
          decoration: BoxDecoration(
              // color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0))),
          child: chatlist(),
        ),
      ),
    );
  }

  chatlist() {
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy('LastMessageTime',descending: true)
                .where('DoctorID', isEqualTo: doctorid["DoctorID"])
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot chatdata = snapshot.data.documents[index];
                    DateTime myDateTime = DateTime.parse(
                        chatdata['LastMessageTime'].toDate().toString());
                    String time = DateFormat('dd MMM').format(myDateTime);
                    return chatitem(time, chatdata);
                  },
                );
              } else {
                return Column(
                  children: <Widget>[
                    Center(child: Text("Their Is No Chat")),
                    Center(
                        child: Text(
                      "Check Your Internet Conectin/Chat is loading...",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ))
                  ],
                );
              }
            }),
      ),
    );
  }

  chatitem(String myDateTime, DocumentSnapshot chatdata) {
    return InkWell(
      onTap: () {
        return Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChatScreen(chatdata)));
      },
      child: Container(
        margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 5.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
            color: Color(0xFFe4f1fe), borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                    radius: 25.0,
                    backgroundImage:
                        NetworkImage("${chatdata['UserProfile']}")),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${chatdata['UserName']}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        "${chatdata['LastMessage']}",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  myDateTime.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.0,
                    //  fontWeight: FontWeight.bold
                  ),
                ),
                chatdata['SeenbyDoctor'] == "yes"
                    ? SizedBox()
                    : Container(
                        width: 40.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        child: Text(
                          'New',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 9.5,
                              fontWeight: FontWeight.bold),
                        ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
