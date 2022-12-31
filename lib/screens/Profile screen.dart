import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reset/Models/Database.dart';
import 'package:reset/SelectUser.dart';

import '../WelcomeScreen.dart';
import '../components/Widgets.dart';
import 'CreateProfile.dart';

class ProfileScreen extends StatefulWidget {
  static const id="ProfileScreen";
  final User? firebaseUser;
  final UserModel? userModel;
  const ProfileScreen({Key? key, this.firebaseUser, required this.userModel}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool anonymity=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black,),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: ListView(
          children: [Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                  Stack(
                    children:[ const Hero(
                        tag: 'hero-profile-picture',
                        child: Avatar.large(url:"https://picsum.photos/seed/3/300/300" ,)),
                      Positioned(
                        bottom: 0,
                          right: 3,
                          child: ClipOval(

                              child: Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.blue,
                                  child: const Icon(Icons.edit,color: Colors.white,size: 20,))))
                    ]
                  ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                widget.userModel?.firstname ?? "No Name",
                style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),),
            SizedBox(height: 4,)
              ,Text(widget.userModel?.email ?? "No email",style: const TextStyle(color: Colors.grey),),

            const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 300,
                  width: 400,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Privacy",style:TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.grey)),
                        SizedBox(height: 5,),
                        Row(children: [
                          Text("Anonymity",style: TextStyle(fontSize: 15),),

                          Padding(
                            padding: const EdgeInsets.only(left: 128.0),
                            child: Switch(value: anonymity, onChanged: (bool val){
                              setState(() {
                                anonymity = val;
                                widget.userModel?.anonymity=val;
                              });

                            }),
                          ),
                        ],),



                        Text("Personal Details",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.grey),),
                        SizedBox(height: 5,),

                        Text("FirstName: ${widget.userModel?.firstname}",style: TextStyle(fontSize: 15,color: Colors.black),),
                        SizedBox(height: 5,),
                        Text("LastName: ${widget.userModel?.lastname}",style: TextStyle(fontSize: 15,color: Colors.black),),
                        SizedBox(height: 5,),
                        Text("Date of birth: ${widget.userModel?.DateOfBirth}",style: TextStyle(fontSize: 15,color: Colors.black),),
                        SizedBox(height: 5,),
                        Text("Gender: ${widget.userModel?.Gender}",style: TextStyle(fontSize: 15,color: Colors.black),),
                        SizedBox(height: 5,),
                        Text("PhoneNumber: ${widget.userModel?.phoneNumber}",style: TextStyle(fontSize: 15,color: Colors.black),),
                      ],
                    ),
                  ),
                ),
              ),


              TextButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileSetup(userModel: widget.userModel!, firebaseUser: widget.firebaseUser,)));
                  },
                  child: const Text("Edit Profile",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),)),
              TextButton(
                onPressed: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacementNamed(context,SelectUserScreen.id);
                },
                child:  Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Sign Out",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 20),),
                      Icon(Icons.exit_to_app_outlined)
                    ],
                  ),
                ))],

          ),
        ]),
      ),
    );
  }
}
