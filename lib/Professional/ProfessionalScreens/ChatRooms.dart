import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reset/Models/Database.dart';
import 'package:reset/Professional/ChatWithUser.dart';

import '../../components/Helpers.dart';


class ChatRooms extends StatefulWidget {
  ProfessionalModel? userModel;
  User? firebaseUser;
  ChatRooms({Key? key,this.firebaseUser,this.userModel}) : super(key: key);

  @override
  _ChatRoomsState createState() => _ChatRoomsState();
}

class _ChatRoomsState extends State<ChatRooms> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
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
                                future: FirebaseHelper.GetUserModelById(ParticipantKeys[0]!),
                                builder: (context,userData){

                                  if(userData.connectionState == ConnectionState.done){
                                    UserModel targetdata = userData.data as UserModel;
                                    return  Container(
                                      decoration: BoxDecoration(shape: BoxShape.rectangle,border: Border.all()),
                                      child: ListTile(
                                        onTap: (){
                                          Navigator.push(context,
                                              MaterialPageRoute(builder:
                                                  (context)=>
                                                  ChatWithUser(
                                                      targetUser: targetdata,
                                                      chatRoomModel: chatRoomModel,
                                                      userModel: widget.userModel ,
                                                      firebaseUser: widget.firebaseUser)));
                                        },
                                        title: Text(targetdata.firstname.toString()),
                                        subtitle: Text(chatRoomModel.lastMessage.toString()),
                                      ),
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
            );
  }
}
