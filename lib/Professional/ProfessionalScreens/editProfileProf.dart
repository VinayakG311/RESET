import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/Database.dart';

class EditProfilePRof extends StatefulWidget {
  const EditProfilePRof({Key? key, this.userModel, this.firebaseUser}) : super(key: key);
  final ProfessionalModel? userModel;
  final User? firebaseUser;

  @override
  State<EditProfilePRof> createState() => _EditProfilePRofState();
}

class _EditProfilePRofState extends State<EditProfilePRof> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String? Qualification =widget.userModel?.Qualification!;
    controller1.text=Qualification!;
  //  String? PriorExp = widget.userModel?
    return Scaffold(
      appBar: AppBar(
          leading: const BackButton(color: Colors.black,)),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Edit Profile",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
            SizedBox(height: 10,),
            Text("Qualification",style: TextStyle(fontSize: 20),),
            TextField(
              controller: controller1,
              maxLines: null,
            ),
            SizedBox(height: 10,),
            Text("Prior Experience",style: TextStyle(fontSize: 20),),
            TextField(
              controller: controller2,
              maxLines: null,
            ),
            SizedBox(height: 10,),
            Text("Charges for Call",style: TextStyle(fontSize: 20),),
            TextField(
              controller: controller3,
              maxLines: null,
            ),
            SizedBox(height: 10,),
            Text("Charges for Chat",style: TextStyle(fontSize: 20),),
            TextField(
              controller: controller4,
              maxLines: null,
            ),


          ],
        ),
      ),
    );
  }
}
