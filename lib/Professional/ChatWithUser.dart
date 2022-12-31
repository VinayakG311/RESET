

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../Models/Database.dart';
var uuid = new Uuid();

class ChatWithUser extends StatefulWidget {
  final ProfessionalModel? userModel;
  final User? firebaseUser;
  final ChatRoomModel chatRoomModel;
  final UserModel? targetUser;
  const ChatWithUser({Key? key,this.userModel,this.firebaseUser, required this.chatRoomModel, this.targetUser}) : super(key: key);
  static const String id="chatWithUser";

  @override
  _ChatWithUserState createState() => _ChatWithUserState();
}

class _ChatWithUserState extends State<ChatWithUser> {
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
        leading: BackButton(color: Colors.black,),
        title: InkWell(
          onTap: (){},
          child: Row(
            children: [
              const CircleAvatar(child: Icon(Icons.person),),
              const SizedBox(width: 10,),
              Text(widget.targetUser?.firstname.toString()??'no name',style: const TextStyle(color: Colors.black),),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
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