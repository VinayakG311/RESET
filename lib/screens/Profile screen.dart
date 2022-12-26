import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reset/Models/Database.dart';
import 'package:reset/SelectUser.dart';

import '../WelcomeScreen.dart';
import '../components/Widgets.dart';
import 'CreateProfile.dart';

class ProfileScreen extends StatelessWidget {
  static const id="ProfileScreen";
  final User? firebaseUser;
  final UserModel? userModel;
  const ProfileScreen({Key? key, this.firebaseUser, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
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
                userModel?.firstname ?? "No Name",
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),),
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
                      Text("FirstName: ${userModel?.firstname}"),
                      Text("LastName: ${userModel?.lastname}"),
                      Text("EmailId: ${userModel?.email}"),
                      Text("Date of birth: ${userModel?.DateOfBirth}"),
                      Text("Gender: ${userModel?.Gender}"),
                      Text("PhoneNumber: ${userModel?.phoneNumber}"),
                    ],
                  ),
                ),
              ),


              TextButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileSetup(userModel: userModel!, firebaseUser: firebaseUser,)));
                  },
                  child: Text("Edit Profile",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),)),
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
