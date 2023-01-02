


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../Models/Database.dart';

class CreatePosts extends StatefulWidget {
  const CreatePosts({Key? key, required this.model, this.firebaseUser}) : super(key: key);
  final ProfessionalModel model;
  final User? firebaseUser;

  @override
  State<CreatePosts> createState() => _CreatePostsState();
}

class _CreatePostsState extends State<CreatePosts> {
  String title='';
  String caption='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Create Post",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
            SizedBox(height: 10,),
            Text("Caption",style: TextStyle(fontSize: 18),),
            TextField(
              decoration: InputDecoration(
                  hintText: "Enter Caption",
                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black))),
              onChanged: (value){
                setState(() {
                  caption=value;
                });
              },

            )




          ],

        ),
      ),
    );
  }
}


// InkWell(
// child: Text("ji"),
// onTap: (){
// Posts posts = Posts(img: "https://picsum.photos/id/227/400/400",uploadedby:widget.model.firstname ,likes: 0,caption: "Hiiii",uid: new Uuid().v1(),bookmarks: 0);
// FirebaseFirestore.instance.collection("Professional").doc(widget.model.uid).collection("posts").doc(posts.uid).set(posts.toMap());
// },
// ),