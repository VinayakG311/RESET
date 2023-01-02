import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reset/Professional/ProfessionalScreens/CreateProfileProf.dart';
import 'package:reset/Professional/ProfessionalScreens/ProfileProf.dart';
import 'package:reset/SelectUser.dart';

import '../Models/Database.dart';
import '../components/Widgets.dart';
import 'ProfessionalProfileSetup.dart';
import 'WelcomeProfessional.dart';

class ProfessionalProfileScreen extends StatefulWidget {
  final ProfessionalModel? userModel;
  final User? firebaseUser;
  const ProfessionalProfileScreen({Key? key,this.userModel,this.firebaseUser}) : super(key: key);
  static const String id="ProfileProfessional";

  @override
  _ProfessionalProfileScreenState createState() => _ProfessionalProfileScreenState();
}

class _ProfessionalProfileScreenState extends State<ProfessionalProfileScreen> {
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
                    children:[ Hero(
                        tag: 'hero-profile-picture',
                        child: Avatar.large(url:widget.userModel?.image! ,)),
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
                          InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Profile",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.grey),),
                                Padding(
                                  padding: const EdgeInsets.only(right: 18.0),
                                  child: Icon(Icons.arrow_forward,size: 25,),
                                )
                              ],
                            ),
                            onTap: (){
                              if(widget.userModel?.Qualification!=null){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileProf(firebaseUser: widget.firebaseUser,userModel: widget.userModel,)));
                            //    print(widget.userModel?.Qualification);
                              }
                              else{

                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreatePRof(firebaseUser: widget.firebaseUser,userModel: widget.userModel,)));

                              }
                            },
                          ),
                          SizedBox(height: 5,),

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
                    //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileSetup(userModel: widget.userModel!, firebaseUser: widget.firebaseUser,)));
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
