import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reset/User/screens/chat%20screen/chat_screen.dart';
import '../../Models/Database.dart';
import '../../components/Helpers.dart';
import '../../components/Widgets.dart';
import '../../pag1-method2.dart';
import 'Profile Screen user/Profile screen.dart';

class Call extends StatefulWidget {
  static const id="call";
  final UserModel? userModel;
  final User? firebaseUser;

  Call({Key? key,this.userModel,this.firebaseUser}) : super(key: key);
  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  @override
  Widget build(BuildContext context) {
        return  Scaffold(
          appBar:  AppBar(
            actions: [
              ProfileIcon(
                  context,(){Navigator.of(context)
                  .push(MaterialPageRoute(
                  builder: (context)=> ProfileScreen(userModel: widget.userModel,firebaseUser: widget.firebaseUser,) ));
              })
            ],
            title: InkWell(
              child: const Text("Talk"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyHomePage(userModel: widget.userModel,firebaseuser: widget.firebaseUser, title: 'RESET',)));
              },),
            titleTextStyle: const TextStyle(color: Colors.black,fontSize: 50.0,fontWeight: FontWeight.bold),
            leading: const BackButton(color: Colors.black,),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: SafeArea(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all( 22.0),
          child: Text("Inbox",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25),),
        ),
            Expanded(
              child:
              Container(
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
              return  Padding(
                padding: const EdgeInsets.only(left: 18.0,right: 18),
                child: Card(
                  shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Avatar.medium(url:targetdata.image),
                        SizedBox(
                          width:200,
                          child: ListTile(
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
                          ),
                        ),
                      ],
                    ),
                  ),
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
              ),
            ),
      ],
    ),
    ),
          ),
        );
    //     ],
    //   ),
    // );
  }


}


