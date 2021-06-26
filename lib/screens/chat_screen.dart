import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweetalert/sweetalert.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
final _fireStore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText = '';

  void getCurrentUser() {
    try {
      final user = _auth.currentUser!;
    loggedInUser = user;
      print("Email ${loggedInUser!.email}");
    }catch(e){print(e);}
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      messageTextController.clear();
                      try{
                     await _fireStore.collection("messages").add({'text':messageText,'sender':loggedInUser!.email});
                      SweetAlert.show(context,
                          title: "Notice",
                          subtitle: "Success!",
                          style: SweetAlertStyle.success
                      );}
                     catch(e){
                        print(e);
                     }
                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('messages').snapshots(),
        builder:(context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          List<MessageBubble> messageBubbles = [];
          final messages = snapshot.data!.docs;
          for(var message in messages){
            final messageText = message["text"];
            final messageSender = message['sender'];
            final currentUser = loggedInUser!.email;
            messageBubbles.add(MessageBubble(sender: messageSender, text: messageText,isCurrentUser: messageSender==currentUser,));


          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20.0),
              children: messageBubbles,
            ),
          );
        }
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.sender,required this.text, required this.isCurrentUser});
  final String sender;
  final String text;
  final bool isCurrentUser;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isCurrentUser?CrossAxisAlignment.start:CrossAxisAlignment.end,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black54
            ),
          ),
          Material(
            elevation: 5.0,
            borderRadius: isCurrentUser?BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)):
            BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)),
            color:isCurrentUser?Colors.grey:Colors.lightBlueAccent,
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,

              ),),
            ),
          ),
        ],
      ),
    );
  }
}

