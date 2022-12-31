import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reset/screens/Meditation%20Screen/BreatheAgain.dart';

import '../../Models/Database.dart';
import '../../components/Widgets.dart';
import '../../pag1-method2.dart';
import '../Profile screen.dart';

class BreathingScreen extends StatefulWidget {
  BreathingScreen({Key? key, this.firebaseUser, this.userModel}) : super(key: key);
  final User? firebaseUser;
  final UserModel? userModel;

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> {
  double w=10;
  String message = "Breathe in..";
  double h=10;
  int val=0;
  void update(){
    setState(() {
      w=385;
      h=385;
    });

  }
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

      body: Container(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          child: Stack(
            children:[
              Padding(
                padding: const EdgeInsets.only(left: 28.0,top: 60),
                child: Text(message,style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
              ),

              Center(child:InkWell(
                  child: Image.asset("images/smiley.png"),
              onTap:(){
                update();
              } ,)),
              Container(
                alignment: Alignment.center,
              child: AnimatedContainer(
                decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xFFF9A826)),
                duration: Duration(seconds: 15),
                width: w,
                height: h,
                onEnd: (){
                  val++;
                  setState(() {
                    message = "Breathe out...";
                    w=0;
                    h=0;

                  });
                  if(val==2) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BreatheAgain()));
                  }
                  },
                //   color: Colors.amber,
              ),
            ),
            ]
          ),
        ),
      ),
    );
  }
}
