import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reset/SelectUser.dart';

import '../Models/Database.dart';
import '../components/Widgets.dart';
import 'ProfessionalProfileSetup.dart';
import 'WelcomeProfessional.dart';

class ProfessionalProfile extends StatefulWidget {
  final ProfessionalModel? userModel;
  final User? firebaseUser;
  const ProfessionalProfile({Key? key,this.userModel,this.firebaseUser}) : super(key: key);
  static const String id="ProfileProfessional";

  @override
  _ProfessionalProfileState createState() => _ProfessionalProfileState();
}

class _ProfessionalProfileState extends State<ProfessionalProfile> {
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
              children: [const Hero(tag: 'hero-profile-picture', child: Avatar.large(url:"https://picsum.photos/seed/3/300/300" ,)),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.userModel?.firstname ?? "No Name",
                    style: const TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),),
                const Divider(),
                SizedBox(
                  height: 200,
                  width: 400,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    color: Colors.grey[300],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Personal Details",style: TextStyle(fontSize: 14),),
                        ),
                        Text("FirstName: ${widget.userModel?.firstname}"),
                        Text("LastName: ${widget.userModel?.lastname}"),
                        Text("EmailId: ${widget.userModel?.email}"),
                        Text("Date of birth: ${widget.userModel?.DateOfBirth}"),
                        Text("Gender: ${widget.userModel?.Gender}"),
                        Text("PhoneNumber: ${widget.userModel?.phoneNumber}"),
                      ],
                    ),
                  ),
                ),


                TextButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileSetupProfessional(userModel: widget.userModel!, firebaseUser: widget.firebaseUser,fromprofile: 1,)));
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
    );;
  }
}
