import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reset/components/Widgets.dart';
import 'package:reset/pag1-method2.dart';

import '../../../Models/Database.dart';

class chatendscreen extends StatefulWidget {
  const chatendscreen({Key? key, this.targetUser, this.userModel, this.firebaseUser}) : super(key: key);
  final ProfessionalModel? targetUser;
  final UserModel? userModel;
  final User? firebaseUser;

  @override
  State<chatendscreen> createState() => _chatendscreenState();
}

class _chatendscreenState extends State<chatendscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("RESET",style: TextStyle(color: Colors.black,fontSize: 35),),
        leading: BackButton(color: Colors.black,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Call ended",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w500),),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text("Your call with the Professional has ended",style: TextStyle(fontSize: 20),),
            ),
            SizedBox(height: 10,),
            RoundedButton(Colors.white, "Go to Home Screen", () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage(title: "RESET",userModel: widget.userModel,firebaseuser: widget.firebaseUser,)));
            }, Colors.black),
            SizedBox(height: 10,),
            RoundedButton(Colors.black, "Report issue", () { }, Colors.white),
            SizedBox(height: 10,),
            RoundedButton(Colors.red, "Report Professional", () { }, Colors.white)
          ],
        ),
      ),
    );
  }
}
