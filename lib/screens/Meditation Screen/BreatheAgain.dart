

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reset/screens/Meditation%20Screen/Breathe.dart';

import '../../Models/Database.dart';
import '../../components/Widgets.dart';
import '../../pag1-method2.dart';
import '../Profile screen.dart';

class BreatheAgain extends StatefulWidget {
  BreatheAgain({Key? key, this.firebaseUser, this.userModel}) : super(key: key);
  final User? firebaseUser;
  final UserModel? userModel;

  @override
  State<BreatheAgain> createState() => _BreatheAgainState();
}

class _BreatheAgainState extends State<BreatheAgain> {
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
          child: const Text("Calm"),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyHomePage(userModel: widget.userModel,firebaseuser: widget.firebaseUser, title: 'RESET',)));
          },),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 50.0,fontWeight: FontWeight.bold),
        leading: const BackButton(color: Colors.black,),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 80.0,top: 20),
            child: Text("Breathe",style: TextStyle(fontSize: 25,color: Colors.grey),),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 38.0,bottom: 18,left: 80),
            child: InkWell(
                child: Image.asset("images/restart.png",width: 250,),
            onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BreathingScreen(userModel: widget.userModel,firebaseUser: widget.firebaseUser,)));
            },),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0,bottom: 18,left: 80),
            child: InkWell(
              child: Image.asset("images/end.png",width: 250,),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage(userModel: widget.userModel,firebaseuser: widget.firebaseUser,title: "RESET",)));

              },),
          ),
        ],
      ),
    );
  }
}
