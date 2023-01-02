


import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reset/components/RoundedButtons.dart';
import 'package:uuid/uuid.dart';

import '../../Models/Database.dart';
File? images;

class CreatePosts extends StatefulWidget {
  const CreatePosts({Key? key, required this.model, this.firebaseUser}) : super(key: key);
  final ProfessionalModel model;
  final User? firebaseUser;

  @override
  State<CreatePosts> createState() => _CreatePostsState();
}

class _CreatePostsState extends State<CreatePosts> {
  int x=1;

  String title='';
  String caption='';
  Future pickImagees() async{
    try{
      final image=await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image==null)return;
      final tempImg =  File(image.path) ;
      setState(() {
        images = tempImg;
      });}on PlatformException catch(e){
      print("Could pick imag$e");
    }
  }
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
            ),
            SizedBox(height: 10,),
            Text("Add image",style: TextStyle(fontSize: 18),),
            IMGChosen(img: images,onpress: (){pickImagees();}),
            RoundedButton(Colors.white, "Post",
                    () {
                       Posts posts = Posts(img: images?.path,uploadedby:widget.model.firstname ,likes: 0,caption: caption,uid: new Uuid().v1(),bookmarks: 0);
                       FirebaseFirestore.instance.collection("Professional").doc(widget.model.uid).collection("posts").doc(posts.uid).set(posts.toMap());


                    }, Colors.black),
      //      ],
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


class IMGChosen extends StatefulWidget {
  IMGChosen({
    Key? key,
    required this.img, required this.onpress
  }) : super(key: key);
  File? img;
  final void Function() onpress;

  @override
  State<IMGChosen> createState() => _IMGChosenState();
}

class _IMGChosenState extends State<IMGChosen> {
  static int x=0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(thickness: 1,color: Colors.black,),
        x==0? widget.img!=null? Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              SizedBox(
                width: 200,
                height: 130,
                child: Image.file(widget.img!),
              ),
              Padding(padding:const EdgeInsets.only(bottom: 110) ,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed:(){
                      //  widget.img=null;
                      setState(() {
                        widget.img=null;
                        images=null;
                      });


                    },
                  ))
            ],
          ),
        )

            :Container(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: widget.onpress,
            child: DottedBorder(
                dashPattern: const [4,4],
                child:Container(
                  height: 130,
                  width: 200,
                  alignment: Alignment.center,
                  child: const SizedBox(

                    child: Icon(Icons.add),
                  ),
                )),
          ),
        ):Container(alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: (){
              widget.onpress;
            },
            child: DottedBorder(
                dashPattern: const [4,4],
                child:Container(
                  height: 130,
                  width: 200,
                  alignment: Alignment.center,
                  child: const SizedBox(

                    child: Icon(Icons.add),
                  ),
                )),
          ),
        ) ,
        const Divider(thickness: 1,color: Colors.black,),

      ],
    );
  }
}