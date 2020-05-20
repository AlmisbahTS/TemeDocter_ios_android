import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:firebase_auth/firebase_auth.dart';
class ChatScreen extends StatefulWidget {
  ChatScreen(this.chatdata);
  final chatdata;
  @override
  _ChatScreenState createState() => _ChatScreenState(chatdata);
}

class _ChatScreenState extends State<ChatScreen> {
  _ChatScreenState(this.chatdata);
  final chatdata;
  final databaseReference = Firestore.instance;
  final messageController = TextEditingController();
  String msgId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(171, 31, 95, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(171, 31, 95, 1),
        title: Text(
          "${chatdata['UserName']}",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                    child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('messages')
                            .where('ChatID', isEqualTo: "${chatdata['UserID']}${['DoctorID']}")
                            .orderBy('MessageTime', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                reverse: true,
                                padding: EdgeInsets.only(top: 14.0),
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (BuildContext context, int index) {
                                  DocumentSnapshot msgdata =
                                      snapshot.data.documents[index];
                                  String message = msgdata["Message"];
                                  DateTime myDateTime = DateTime.parse(
                                      msgdata['MessageTime']
                                          .toDate()
                                          .toString());
                                  String time = DateFormat('dd MMM hh:mm a')
                                      .format(myDateTime);
                                  msgId = msgdata["MessageID"];
                                  final bool isMe =
                                      msgdata["Sender"] == "Doctor";
                                  return _buildMessage(
                                    time,
                                    message,
                                    isMe,
                                  );
                                });
                          } else {
                            return Column(
                              children: <Widget>[
                                Center(child: Text("Their Is No Chat")),
                              ],
                            );
                          }
                        }),
                  )),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }

  _buildMessage(String time, String message, bool isMe) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      margin: isMe
          ? EdgeInsets.only(top: 7.0, bottom: 8.0, left: 80.0)
          : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      decoration: isMe
          ? BoxDecoration(
              color: Color.fromRGBO(253, 49, 144, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)))
          : BoxDecoration(
              color: Color.fromRGBO(253, 49, 144, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$time",
            style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(" $message",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.photo),
          //   iconSize: 25.0,
          //   color: Theme.of(context).primaryColor,
          //   onPressed: () {},
          // ),
          Expanded(
            child: TextField(
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration(hintText: 'Send a message..'),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              createRecord();
            },
          ),
        ],
      ),
    );
  }

  void createRecord() async {
    String msgTxt = messageController.text;
    messageController.text = "";
    await databaseReference.collection("messages").add({
      'Message': '$msgTxt',
      'Sender': 'Doctor',
      'Receiver': 'User',
      'DoctorID': chatdata['DoctorID'],
      
      'ChatID': "${chatdata['UserID']}${['DoctorID']}",
      'UserID': chatdata['UserID'],
      'MessageTime': FieldValue.serverTimestamp()
    });
    await databaseReference
        .collection("chat")
        .document("${chatdata['UserID']}${chatdata['DoctorID']}")
        .setData({
      'ChatID': chatdata["ChatID"],
      'DoctorID': chatdata["DoctorID"],
      'LastMessage': messageController.text,
      'LastMessageTime': FieldValue.serverTimestamp(),
      'SeenbyDoctor': "yes",
      'SeenbyUser': "no",
      'UserID': chatdata['UserID'],
      'DoctorProfile': chatdata["DoctorProfile"],
      'UserProfile': chatdata["UserProfile"],
      'UserName': chatdata['UserName'],
      'DoctorName':chatdata['DoctorName']
    });
  }
}
