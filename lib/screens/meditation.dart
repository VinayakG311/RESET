  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
  import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reset/screens/Meditation%20Screen/Breathe.dart';

import '../Models/Database.dart';
import 'Meditation Screen/Calming.dart';

  class meditation extends StatelessWidget {
    final User? firebaseUser;
    final UserModel? userModel;
    meditation({Key? key, this.firebaseUser, this.userModel}) : super(key: key);
    @override
    Widget build(BuildContext context) {
      return  Scaffold(
        body: Column(

          children:[Padding(
            padding: const EdgeInsets.fromLTRB(20.0,50,25,0),
            child: Row(children:[Text("To Relax",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)]),
          ),Row(children:[Padding(
            padding: const EdgeInsets.fromLTRB(0.0,10,0,75),
            child: Image.asset("images/MeditationWoman.png",width: 360,),
          )]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SizedBox(
                width: 300,
                height: 50,
                child: TextButton(style: OutlinedButton.styleFrom(shape: StadiumBorder(),backgroundColor: (Colors.black),
      ),
                    onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BreathingScreen(userModel: userModel,firebaseUser: firebaseUser,)));
                    },
                    child: Text("Breathe",style: TextStyle(color: Colors.white),)),
              )],
            ),
            Padding(padding: EdgeInsets.all(25)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SizedBox(
                width: 300,
                height: 50,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(color: Colors.black,width: 2)
                ),onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context)=>CalmingSounds(firebaseUser: firebaseUser,userModel: userModel,)));
                }, child: Text(
                  "Calming Sounds",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),)),
              )],
            )
          ]
        ),
      );
    }
  }
