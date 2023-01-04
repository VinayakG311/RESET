import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reset/Professional/ProfessionalScreens/Profile%20Professional/editProfileProf.dart';

import '../../../Models/Database.dart';

class ProfileProf extends StatefulWidget {
  const ProfileProf({Key? key, this.userModel, this.firebaseUser}) : super(key: key);
  final ProfessionalModel? userModel;
  final User? firebaseUser;

  @override
  State<ProfileProf> createState() => _ProfileProfState();
}

class _ProfileProfState extends State<ProfileProf> {

  @override
  Widget build(BuildContext context) {
    ProfessionalModel professionalModel = widget.userModel!;
    double? val = professionalModel.rating?.toDouble();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar:  AppBar(
        leading: const BackButton(color: Colors.black,),

      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            Center(child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: CircleAvatar(
                    backgroundImage:CachedNetworkImageProvider(professionalModel.image!),
                    radius: 65,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(professionalModel.firstname!,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),),
                ),
                RatingBarIndicator(
                    rating: val!,
                    itemBuilder: (BuildContext context, int index) {
                      return Icon(Icons.star,color: Colors.amber,);
                    }),

                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Qualification",style: TextStyle(color: Colors.grey,fontSize: 25),),
                      Text(professionalModel.Qualification!),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Prior Experience",style: TextStyle(color: Colors.grey,fontSize: 25)),
                      Text(professionalModel.Priorexp!),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Charges",style: TextStyle(color: Colors.grey,fontSize: 25)),
                      Row(
                        children: [
                          Text("Chat: "),
                          Text(professionalModel.chat.toString())
                        ],
                      ),
                      Row(
                        children: [
                          Text("Call: "),
                          Text(professionalModel.call.toString())
                        ],
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 20,),


              ],
            )),
            InkWell(
              child: Text("Edit Profile"),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditProfilePRof(firebaseUser: widget.firebaseUser,userModel: widget.userModel,type: 1,)));
              },
            )
          ],
        ),
      ),
    );
  }
}
