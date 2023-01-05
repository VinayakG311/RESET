import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reset/User/screens/chat%20screen/ProfessionalProfile.dart';
import 'package:reset/User/screens/chat%20screen/chat_endscreen.dart';
import 'package:reset/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uuid/uuid.dart';
import '../../../Models/Database.dart';
import '../../../components/Widgets.dart';
var uuid = new Uuid();
//
// final _firestore=FirebaseFirestore.instance;
// late User loggedinUser;
class ChatScreen extends StatefulWidget {
  final ProfessionalModel? targetUser;
  final UserModel? userModel;
  final User? firebaseUser;
  final ChatRoomModel chatRoomModel;

  ChatScreen({Key? key,this.userModel,this.firebaseUser, this.targetUser,required this.chatRoomModel}) : super(key: key);

  static const String id ="chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = new TextEditingController();
  void SendMessage()async{
    String message= controller.text.trim();
    controller.clear();
    if(message!=''){
      MessageModel newmessage = MessageModel(
          messageid:uuid.v1() ,
          sender:widget.userModel?.uid ,
          createdon:DateTime.now(),
          text: message,
          seen: false
      );
      FirebaseFirestore.instance.collection('chatrooms')
          .doc(widget.chatRoomModel.chatRoomId)
          .collection("messages").doc(newmessage.messageid).set(newmessage.toMap());
      widget.chatRoomModel.lastMessage=message;
      FirebaseFirestore.instance.collection("chatrooms").doc(widget.chatRoomModel.chatRoomId).set(widget.chatRoomModel.toMap());

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(
            icon: CupertinoIcons.back,
            onTap: (){
              Navigator.of(context).pop();
            },
          ),
        ),
        title: InkWell(
          //splashColor: Colors.blue,
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfessionalProfile(model: widget.targetUser,userModel: widget.userModel,firebaseUser: widget.firebaseUser,)));
          },
          child: Row(
            children: [
              Avatar.medium(url: widget.targetUser?.image.toString(),),
              const SizedBox(width: 10,),
              Text(widget.targetUser?.firstname.toString()??'User',style: const TextStyle(color: Colors.black),),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: SizedBox(
                  width: 100,
                    height: 60,
                    child: RoundedButton(Colors.black, "End call", () {
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          title:  const Text('End Call?',style: TextStyle(fontSize: 25),),
                          content: const Text('Do you want to End Call?',style: TextStyle(fontSize: 15),),
                          actions: <Widget>[
                            TextButton(onPressed: (){
                              Navigator.pop(context, 'OK');
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>chatendscreen(firebaseUser: widget.firebaseUser,userModel: widget.userModel,targetUser: widget.targetUser,)));

                            }, child: Text("OK")),
                            TextButton(onPressed: (){
                              Navigator.pop(context, 'Cancel');
                            }, child: Text("Cancel")),

                          ],
                        );
                      });
                    }, Colors.white)),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Divider(height: 8,),
              Expanded(
                child: Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("chatrooms")
                        .doc(widget.chatRoomModel.chatRoomId).collection('messages').orderBy("createdon",descending: true).snapshots(),
                    builder: (context,snapshots){
                      if(snapshots.connectionState == ConnectionState.active){
                        if(snapshots.hasData){
                          QuerySnapshot datasnapshot = snapshots.data as QuerySnapshot;
                          return ListView.builder(
                              reverse: true,
                              itemCount: datasnapshot.docs.length,
                              itemBuilder: (context,index){
                                MessageModel currentmessage = MessageModel
                                    .fromMap(datasnapshot.docs[index].data() as Map<String,dynamic>);
                                if(currentmessage.sender == widget.userModel?.uid){
                                return MessageBubble(text: currentmessage.text.toString(), sender: currentmessage.sender, isme: true);}
                                else{
                                  return MessageBubble(text: currentmessage.text.toString(), sender: currentmessage.sender, isme: false);
                                }
                                // return Row(
                                //   mainAxisAlignment: (currentmessage.sender == widget.userModel?.uid) ? MainAxisAlignment.end : MainAxisAlignment.start,
                                //   children: [
                                //     Container(
                                //         margin: const EdgeInsets.symmetric(
                                //           vertical: 2,
                                //         ),
                                //         padding: const EdgeInsets.symmetric(
                                //           vertical: 10,
                                //           horizontal: 10,
                                //         ),
                                //         decoration: BoxDecoration(
                                //           color: (currentmessage.sender == widget.userModel?.uid) ? Colors.grey : Theme.of(context).colorScheme.secondary,
                                //           borderRadius: BorderRadius.circular(5),
                                //         ),
                                //         child: Text(
                                //           currentmessage.text.toString(),
                                //           style: const TextStyle(
                                //             color: Colors.white,
                                //           ),
                                //         )
                                //     ),
                                //   ],
                                // );
                              });

                        }
                        else if(snapshots.hasError){
                          return const Center(
                            child: Text("An error has occured"),
                          );


                        }
                        else{
                          return const Center(
                            child: Text("Say hi"),
                          );
                        }
                      }
                      else{
                        return const Center(child: CircularProgressIndicator(),);
                      }
                    },
                  ),
                ),
              ),
              Container(
                color:Colors.grey[200],
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Row(
                  children: [
                    Flexible(
                        child: TextField(
                          controller: controller,
                          style: const TextStyle(color: Colors.black),
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter message",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        )),
                    IconButton(
                        onPressed:(){
                          SendMessage();
                        },
                        icon: const Icon(Icons.send,color: Colors.black,))
                  ],
                ),
              )
            ],
          ),
        ),
      )
      ,
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({required this.text,required this.sender,required this.isme}) ;
  final String? sender;
  final String text;
  final bool isme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: isme? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(sender!,style: const TextStyle(fontSize: 12,color: Colors.white)),
          Material(
              elevation: 5,
              borderRadius: isme? const BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: const Radius.circular(30),bottomRight: Radius.circular(30)):const BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),

              color: isme? Colors.lightBlueAccent:Colors.black54,
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child: Text(text,style: const TextStyle(fontSize: 15,color: Colors.white),))),
        ],
      ),
    );
  }
}


//   final messagecontroller=TextEditingController();
//   late String messagetext;
//   final _auth=FirebaseAuth.instance;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getCurrentUser();
//   }
//   void getCurrentUser() async{
//     try {
//       final user = await _auth.currentUser;
//
//       if (user != null) {
//         setState(() {
//           loggedinUser = user;
//         });
//
//       }
//     }
//     catch(e){
//       print(e);
//     }
//   }
//
//   void messagesStream() async {
//     await  for(var snapshot in _firestore.collection('messages').snapshots()){
//       for(var message in snapshot.docs){
//         print(message.data());
//       }
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: null,
//         actions: <Widget>[
//           IconButton(
//               icon: const Icon(Icons.close),
//               onPressed: () {
//                 messagesStream();
//                 // _auth.signOut();
//                 // Navigator.pop(context);
//               }),
//         ],
//         title: const Text('⚡️Chat'),
//         backgroundColor: Colors.lightBlueAccent,
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             const MessagesStream(),
//             Container(
//               decoration: kMessageContainerDecoration,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(
//                     child: TextField(
//                       controller: messagecontroller,
//                       onChanged: (value) {
//                         messagetext=value;
//                       },
//                       decoration: kMessageTextFieldDecoration,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       messagecontroller.clear();
//                       _firestore.collection('messages').add({
//                         'text': messagetext,
//                         'sender':loggedinUser.email,
//                         'messageTime':DateTime.now()
//                       });
//                     },
//                     child: const Text(
//                       'Send',
//                       style: kSendButtonTextStyle,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class MessagesStream extends StatelessWidget {
//   const MessagesStream({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream:_firestore.collection('messages').orderBy('messageTime',descending: false).snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if(snapshot.hasData){
//           final messages=snapshot.data?.docs;
//           List<MessageBubble> messageWidget=[];
//           for(var mess in messages!){
//             final text=mess.get('text');
//             final sender=mess.get('sender');
//
//             final currentUser=loggedinUser.email;
//             final widget=MessageBubble(text: text, sender: sender,isme: currentUser==sender);
//
//
//             messageWidget.add(widget);
//
//           }
//           return Expanded(
//             child: ListView(
//
//               padding: const EdgeInsets.symmetric(vertical:20,horizontal: 10),
//               children: messageWidget,
//             ),
//           );
//
//         }
//         else{
//           return const Center(
//             child: CircularProgressIndicator(backgroundColor: Colors.lightBlueAccent,),
//           );
//         }
//       },);
//   }
// }
//
