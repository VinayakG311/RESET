  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import '../../../Models/Database.dart';
import '../../../components/Widgets.dart';
import '../../../pag1-method2.dart';
import '../Profile Screen user/Profile screen.dart';
import 'journalconf2.dart';
  class JournalConfirm extends StatefulWidget {
    JournalConfirm({Key? key, this.userModel, this.firebaseUser}) : super(key: key);
    final UserModel? userModel;
    final User? firebaseUser;
    @override
    State<JournalConfirm> createState() => _JournalConfirmState();
  }

  class _JournalConfirmState extends State<JournalConfirm> {
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
        body: Padding(
          padding: const EdgeInsets.only(left: 28.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


                Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 25.0,bottom: 25.0,top: 40.0),
                  child: Image.asset("images/girlwithbook.png",width: 1500,),
                ),
                Flexible(child: Text("did talking about your day make you feel better?",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),)),
                RoundedButton(Colors.black, "Yes :)", () { Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Journalask(userModel: widget.userModel,firebaseUser: widget.firebaseUser,)));}, Colors.white),
                RoundedButton(Colors.white, "No  :(", () { Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Journalask(userModel: widget.userModel,firebaseUser: widget.firebaseUser,)));}, Colors.black),
              ],

          ),),
        ),
      );
    }
  }
