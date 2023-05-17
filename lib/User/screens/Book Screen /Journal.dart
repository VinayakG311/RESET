import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../Models/Database.dart';
import '../../../components/Widgets.dart';
import '../../../pag1-method2.dart';
import '../Profile Screen user/Profile screen.dart';
import 'journalconfirm.dart';

class Journal extends StatefulWidget {
  final int val;
  final UserModel? userModel;
  final User? firebaseUser;
  Journal({Key? key, required this.val, this.userModel, this.firebaseUser}) : super(key: key);

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  String? text;
  TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body:  SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Row(
                  children: [
                    Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Image.asset("images/booksgirlsad.png",width: 150,),
                  ),
                    Expanded(

                      child: Text((() {
                        if(widget.val==0){
                          return "That's great! tell me about it";}
                        if(widget.val==1){
                          return "that's nice! did something good happen?";
                        }
                        if(widget.val==2){
                          return "its okay! tell me about it";}
                        if(widget.val==3){
                          return "what has caused you to feel bad today";
                        }
                        if(widget.val==4){
                          return "Dont feel down! try to write about it";}
                        if(widget.val==5){
                          return "its okay! just write how you feeling";
                        }
                        return "How are you feeling";
                      })(),style: const TextStyle(color: Colors.black,fontSize: 24)),
                    )

                 ],),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 400,
                    width: 400,

                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                      color: Color(0xFFFFE985),
                      child: TextField(
                        controller: controller,
                        maxLines: null,
                        onChanged: (val){
                          text=val;
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 315.0),
                  child: InkWell(
                      child: Icon(Icons.arrow_forward,size: 50,color: Colors.grey,),
                  onTap: () async {
                        JournalModel journal= new JournalModel(Useruid: widget.userModel?.uid,Date: DateTime.now().toString(),Content: text,uid: new Uuid().v1());
                   //     print(text);
                    await FirebaseFirestore.instance.collection("Journals").doc(journal.Useruid).collection("journals").doc(journal.uid).set(journal.toMap()).then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>JournalConfirm(firebaseUser: widget.firebaseUser,userModel: widget.userModel,))));

                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>JournalConfirm(firebaseUser: widget.firebaseUser,userModel: widget.userModel,)));
                  },),
                )

              ]
          ),
      )

    );
  }
}
