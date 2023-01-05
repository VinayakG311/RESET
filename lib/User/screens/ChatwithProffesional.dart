import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reset/Models/Database.dart';
import 'package:uuid/uuid.dart';
import 'chat screen/chat_screen.dart';
import 'Profile Screen user/Profile screen.dart';
var uuid  = new Uuid();

class ChatWithProffesional extends StatefulWidget {
  final UserModel? userModel;
  final User? firebaseUser;
  static const id = "ChatwithProffesional";
  const ChatWithProffesional({Key? key,required this.userModel,required this.firebaseUser}) : super(key: key);
  @override
  _ChatWithProffesionalState createState() => _ChatWithProffesionalState();
}

class _ChatWithProffesionalState extends State<ChatWithProffesional> {
  List professionals=["Dr Mark","Dr Martha","Dr Jacob","Dr samantha","Dr Bailey","Dr Anthony","Dr Adira","Dr sarah","Dr Alice","Dr Mathew"];
  late TextEditingController texteditor = new TextEditingController();
  Future<ChatRoomModel?> getChatroomModel(ProfessionalModel? targetUser)async{
    ChatRoomModel? chatroom;

    QuerySnapshot snapshot=await FirebaseFirestore.instance.collection("chatrooms")
        .where("participants.${widget.userModel?.uid}",isEqualTo: true)
        .where("participants.${targetUser?.uid}",isEqualTo: true).get();
    if(snapshot.docs.isNotEmpty){
      var docdata=snapshot.docs[0].data();
      ChatRoomModel existingRoom = ChatRoomModel.fromMap(docdata as Map<String,dynamic>);
      chatroom=existingRoom;
    }
    else{
      print(widget.userModel?.uid);
      ChatRoomModel chatRoomModel = ChatRoomModel(
          chatRoomId:uuid.v1() ,
          lastMessage: '',
          participants:{
            widget.userModel?.uid.toString():true,
            targetUser?.uid.toString():true
          }
      );
      await FirebaseFirestore.instance.collection("chatrooms")
          .doc(chatRoomModel.chatRoomId)
          .set(chatRoomModel.toMap());
      chatroom=chatRoomModel;
    }
    return chatroom;

  }
  String name='';
  @override
  void initState(){
    // initiateSearch();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: BackButton(color: Colors.black,),
            title: Card(
              child: TextField(
                controller: texteditor,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search), hintText: 'Search...'),
                onChanged: (val) {
                  setState(() {
                  });
                },

              ),
            )),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Professional').where('email',isEqualTo: texteditor.text).snapshots(),
            builder: (context, snapshots) {
              if(snapshots.connectionState == ConnectionState.active){
                if(snapshots.hasData){

                  QuerySnapshot datasnapshot = snapshots.data as QuerySnapshot;
                  if(datasnapshot.docs.isNotEmpty){
                    Map<String,dynamic> usermap = datasnapshot.docs[0].data() as Map<String,dynamic>;
                    ProfessionalModel searchedUser = ProfessionalModel.fromMap(usermap);
                    //usermodel banalo ;
                    return ListTile(
                      onTap: ()async{
                        ChatRoomModel? chatroom=await getChatroomModel(searchedUser);
                        if(chatroom!=null){
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=> ChatScreen(
                                targetUser: searchedUser,
                                firebaseUser:widget.firebaseUser ,
                                userModel: widget.userModel,
                                chatRoomModel:chatroom ,)
                          ));}
                      },
                      title: Text(usermap['email']),
                      trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                    );
                  }
                  else{
                    return const Text('No results');
                  }


                }
                else if(snapshots.hasError){
                  return const Text('An Error Occured');
                }
                else{
                  return const Text('No Results found');
                }

              }
              else{
                return CircularProgressIndicator();
              }
            }
        ));
  }
  }

  //   return Scaffold(
  //         appBar:AppBar(
  //           leading: const BackButton(color: Colors.black,),
  //           actions: [
  //             ProfileIcon(context,
  //                     (){Navigator.of(context)
  //                         .push(MaterialPageRoute(
  //                         builder: (context)=> ProfileScreen(userModel: widget.userModel,firebaseUser: widget.firebaseUser,) ));})
  //           ],
  //           titleSpacing: 0.1,
  //         title:const Text("Meet the Proffesionals", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
  //         centerTitle: true,),
  //         body: Column(
  //               children: [
  //               Row(
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 8.0),
  //                     child: IconButton(onPressed: (){}, icon: const Icon(Icons.search,color: Colors.black,size: 40,)),),
  //                   Flexible(
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(right: 32.0),
  //                       child: TextField(
  //                         decoration: const InputDecoration(hintText: "search for professional"), onChanged: (value){},),),),
  //                   const SizedBox(height: 20,)
  //                 ],),
  //                 Expanded(
  //                   child: SizedBox(
  //                     height: 200,
  //                     child: ListView(
  //                     shrinkWrap: true,
  //                     scrollDirection: Axis.vertical,
  //                     children:[
  //                     for(var i=0;i<professionals.length;i++) Proffesionals(professionals[i]),
  //                     ],
  //                     ),
  //                   ),
  //                 )
  //               ],
  //         ),
  //               // body:Expanded(
  //               //   child: SizedBox(
  //               //     height: 200,
  //               //     child: ListView(
  //               //       shrinkWrap: true,
  //               //       scrollDirection: Axis.vertical,
  //               //       children:[
  //               //         for(var i=0;i<professionals.length;i++) Proffesionals(professionals[i]),
  //               //         ],
  //               //     ),
  //               //   ),
  //               // )
  //         );
  //           }
  //
  // // Padding ProfileIcon(BuildContext context) {
  // //   return Padding(
  // //             padding: const EdgeInsets.only(right: 24),
  // //             child: Avatar.medium(
  // //               url: "https://picsum.photos/seed/3/300/300",
  // //               onTap: (){
  // //                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProfileScreen(userModel: widget.userModel,firebaseUser: widget.firebaseUser,) ));
  // //               },
  // //             ),
  // //           );
  // // }
  //
  // Row Proffesionals(name) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.all(20.0),
  //         child: SizedBox(
  //           width: 300,
  //           height: 60,
  //           child: OutlinedButton(
  //               style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),), side: const BorderSide(color: Colors.black,width: 2)
  //               ),onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=> ChatScreen(userModel:widget.userModel ,firebaseUser:widget.firebaseUser ,)));}, child: Text(name,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w700),)),
  //         ),
  //       ),
  //
  //     ],
  //   );
  // }

