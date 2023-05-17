import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reset/pag1-method2.dart';
import '../../../Models/Database.dart';
import '../../../components/Widgets.dart';
import '../Profile Screen user/Profile screen.dart';
import 'Journal.dart';
import 'JournalsStored.dart';

class Journalask extends StatefulWidget {
  Journalask({Key? key, this.userModel, this.firebaseUser}) : super(key: key);
  final UserModel? userModel;
  final User? firebaseUser;
  @override
  State<Journalask> createState() => _JournalaskState();
}

class _JournalaskState extends State<Journalask> {
  @override
  Widget build(BuildContext context) {
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
      body: Center(child:
      Padding(
        padding: const EdgeInsets.only(left: 28.0,right: 28.0,top: 50,bottom: 28.0),
        child: Column(
          children: [
            Text(
              "Your Journal has been saved!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 30),),
            RoundedButton(
                Colors.black,
                "Write another Journal",
                    (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Journal(val: 7,userModel: widget.userModel,firebaseUser: widget.firebaseUser,)));
                    },
                Colors.white),
            RoundedButton(Colors.black, "Check saved Journals", (){
              print(widget.userModel);
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> JournalsStored(userModel: widget.userModel,firebaseUser: widget.firebaseUser)));

            }, Colors.white),
            RoundedButton(
                Colors.black,
                "Go to Home Screen",
                    (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyHomePage(userModel: widget.userModel,firebaseuser: widget.firebaseUser, title: 'RESET',)));
            },
                Colors.white),



          ],
        ),
      ),),
    );
  }
}
