import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Models/Database.dart';
import '../../../components/Widgets.dart';
import '../../../pag1-method2.dart';
import '../Profile Screen user/Profile screen.dart';

class JournalsStored extends StatefulWidget {
  JournalsStored({Key? key, this.userModel, this.firebaseUser}) : super(key: key);
  final UserModel? userModel;
  final User? firebaseUser;
  @override
  State<JournalsStored> createState() => _JournalsStoredState();
}

class _JournalsStoredState extends State<JournalsStored> {
  @override
  Widget build(BuildContext context) {
    String? x=widget.userModel?.uid;
    return Scaffold(
      appBar:  AppBar(
        actions: [
          ProfileIcon(
              context,(){Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (context)=> ProfileScreen(userModel: widget.userModel,firebaseUser: widget.firebaseUser,) ));
          })
        ],
        title: InkWell(
          child: Text("Journal"),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyHomePage(userModel: widget.userModel,firebaseuser: widget.firebaseUser, title: 'RESET',)));
          },),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 50.0,fontWeight: FontWeight.bold),
        leading: const BackButton(color: Colors.black,),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Journals").doc(x!).collection("journals").orderBy("Date",descending: true).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if(snapshot.connectionState==ConnectionState.active){
                          if(snapshot.hasData){
                            QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
                       //     return Text("got smth");
                            return ListView.builder(
                              itemCount: datasnapshot.docs.length,
                                itemBuilder: (context,index){
                                JournalModel journal = JournalModel.fromMap(datasnapshot.docs[index].data() as Map<String,dynamic>);
                                return indJournal(Content: journal.Content,Date: journal.Date,);
                                });
                          }
                          else{
                            return Text("Add More Journal!!");
                          }
                        }
                        else{
                          return Text("Add More Journal!!");
                        }
                      },

                ))
              ],
            ),
          ))
    );
  }
}


class indJournal extends StatelessWidget {
  final String? Content;
  final String? Date;
  indJournal({Key? key, this.Content, this.Date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 100,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(Content!,overflow: TextOverflow.ellipsis,maxLines: 3,),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
        color: Color(0xFFFFE985),
      ),
    );
  }
}
