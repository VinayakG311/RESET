import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reset/Professional/ProfessionalScreens/Profile%20Professional/ProfileProf.dart';

import '../../../Models/Database.dart';

class EditProfilePRof extends StatefulWidget {
  const EditProfilePRof({Key? key, this.userModel, this.firebaseUser, this.type}) : super(key: key);
  final ProfessionalModel? userModel;
  final User? firebaseUser;
  final int? type;

  @override
  State<EditProfilePRof> createState() => _EditProfilePRofState();
}

class _EditProfilePRofState extends State<EditProfilePRof> {
  // int x=2;
  // @override
  // void initState(){
  //   x=widget.type!;
  //   super.initState();
  // }
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if(widget.type==1) {
      String? Qualification = widget.userModel?.Qualification!;
      controller1.text = Qualification!;
      String? PriorExp = widget.userModel?.Priorexp!;
      controller2.text = PriorExp!;
      int? call = widget.userModel?.call!;
      controller3.text = call!.toString();
      int? chat = widget.userModel?.chat!;
      controller4.text = chat!.toString();
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          leading: const BackButton(color: Colors.black,)),
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("Edit Profile",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
                SizedBox(height: 10,),
                Text("Qualification",style: TextStyle(fontSize: 20),),
                TextFormField(
                  controller: controller1,
                  maxLines: null,
                  validator: (value){
                    if(value=="" || value==null){
                      return "Field cannot be empty";
                    }
                    return null;
                  },
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
                  keyboardType: TextInputType.number,
                  controller: controller3,
                  maxLines: null,
                ),
                SizedBox(height: 10,),
                Text("Charges for Chat",style: TextStyle(fontSize: 20),),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: controller4,
                  maxLines: null,
                ),
                Center(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 38.0),
                      child: Text("Save Changes"),
                    ),
                    onTap: () async {
                      if(key.currentState!.validate()) {
                        widget.userModel?.Qualification = controller1.text;
                        widget.userModel?.Priorexp = controller2.text;
                        widget.userModel?.call = int.parse(controller3.text);
                        widget.userModel?.chat = int.parse(controller4.text);
                        ProfessionalModel model = widget.userModel!;
                        await FirebaseFirestore.instance.collection(
                            "Professional").doc(widget.userModel?.uid).set(model
                            .toMap());
                        Navigator.of(context).push(MaterialPageRoute(builder: (
                            context) =>
                            ProfileProf(firebaseUser: widget.firebaseUser,
                              userModel: widget.userModel,)));
                      }
                      },
                  ),
                )

               // RoundedButton()


              ],
            ),
          ),
        ),
      ),
    );
  }
}
