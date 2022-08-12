
import 'package:flutter/material.dart';
import 'package:reset/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore=FirebaseFirestore.instance;
late User loggedinUser;
class ChatScreen extends StatefulWidget {

  static const String id ="chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messagecontroller=TextEditingController();
  late String messagetext;
  final _auth=FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser() async{
    try {
      final user = await _auth.currentUser;

      if (user != null) {
        setState(() {
          loggedinUser = user;
        });

      }
    }
    catch(e){
      print(e);
    }
  }

  void messagesStream() async {
    await  for(var snapshot in _firestore.collection('messages').snapshots()){
      for(var message in snapshot.docs){
        print(message.data());
      }
    }
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
                messagesStream();
                // _auth.signOut();
                // Navigator.pop(context);
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
                      controller: messagecontroller,
                      onChanged: (value) {
                        messagetext=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messagecontroller.clear();
                      _firestore.collection('messages').add({
                        'text': messagetext,
                        'sender':loggedinUser.email,
                        'messageTime':DateTime.now()
                      });
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
      stream:_firestore.collection('messages').orderBy('messageTime',descending: false).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData){
          final messages=snapshot.data?.docs;
          List<MessageBubble> messageWidget=[];
          for(var mess in messages!){
            final text=mess.get('text');
            final sender=mess.get('sender');

            final currentUser=loggedinUser.email;
            final widget=MessageBubble(text: text, sender: sender,isme: currentUser==sender);


            messageWidget.add(widget);

          }
          return Expanded(
            child: ListView(

              padding: EdgeInsets.symmetric(vertical:20,horizontal: 10),
              children: messageWidget,
            ),
          );

        }
        else{
          return Center(
            child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,),
          );
        }
      },);
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({required this.text,required this.sender,required this.isme}) ;
  final String sender;
  final String text;
  final bool isme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: isme? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(sender,style: TextStyle(fontSize: 12,color: Colors.white)),
          Material(
            elevation: 5,
            borderRadius: isme? BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)):BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),

            color: isme? Colors.lightBlueAccent:Colors.black54,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child: Text('$text',style: TextStyle(fontSize: 15,color: Colors.white),))),
        ],
      ),
    );
  }
}
