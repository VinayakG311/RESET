import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reset/chat_screen.dart';
import 'package:reset/screens/ChatwithProffesional.dart';

import '../Models/Database.dart';
import '../components/Helpers.dart';

class Call extends StatefulWidget {
  final UserModel? userModel;
  final User? firebaseUser;

  Call({Key? key,this.userModel,this.firebaseUser}) : super(key: key);
  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  @override
  Widget build(BuildContext context) {
        return  SafeArea(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
    TextButton(
            child: Text("Click this"),
            onPressed: (){
              Navigator.of(context).pushNamed(ChatWithProffesional.id);
            },
          ),

        Expanded(
          child: Container(
          child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("chatrooms").where("participants.${widget.userModel?.uid}",isEqualTo:true).snapshots(),
          builder: (context,snapshots){
          if(snapshots.connectionState== ConnectionState.active){

          if(snapshots.hasData){
          QuerySnapshot chatRoomSnapshot = snapshots.data as QuerySnapshot;

          return ListView.builder(
          itemCount: chatRoomSnapshot.docs.length,
          itemBuilder: (context,index){

          ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(chatRoomSnapshot.docs[index].data() as Map<String,dynamic>);
          Map<String?,dynamic> participants = chatRoomModel.participants!;

          List<String?> ParticipantKeys = participants.keys.toList();
          ParticipantKeys.remove(widget.userModel?.uid);
          //  return// Container();
          return FutureBuilder(
          future: FirebaseHelperPro.GetUserModelById(ParticipantKeys[0]!),
          builder: (context,userData){

          if(userData.connectionState == ConnectionState.done){
          ProfessionalModel targetdata = userData.data as ProfessionalModel;
          return  ListTile(
          onTap: (){
          Navigator.push(context,
          MaterialPageRoute(builder:
          (context)=>
          ChatScreen(
          targetUser: targetdata,
          chatRoomModel: chatRoomModel,
          userModel: widget.userModel,
          firebaseUser: widget.firebaseUser)));
          },
          title: Text(targetdata.firstname.toString()),
          subtitle: Text(chatRoomModel.lastMessage.toString()),
          )
          ;
          }
          else{
          return Container();
          }

          });

          });

          }
          else if(snapshots.hasError){
          return const Center(child: Text("Error"),);

          }
          else{
          return const Center(child: Text("No chats"),);
          }

          }
          else{
          return const Center(child: CircularProgressIndicator(),);

          }

          },
          ),
          ),
        ),
      ],
    ),
    );
    //     ],
    //   ),
    // );
  }


}


