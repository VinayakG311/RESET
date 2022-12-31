import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../Models/Database.dart';
import '../../components/Widgets.dart';
import '../../pag1-method2.dart';
import '../Profile screen.dart';

class ProfessionalProfile extends StatefulWidget {
  ProfessionalProfile({Key? key,this.model, this.firebaseUser, this.userModel}) : super(key: key);
  final ProfessionalModel? model;
  final User? firebaseUser;
  final UserModel? userModel;
  static const id="ProfessionalProfileforuser";
  @override
  State<ProfessionalProfile> createState() => _ProfessionalProfileState();
}

class _ProfessionalProfileState extends State<ProfessionalProfile> {
  late ProfessionalModel professionalModel ;
  late bool? isfollowing=false;
  Future callmethod() async{
    var data=FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("following").where(
        "uid",isEqualTo: widget.model?.uid);
    var d= await data.get();
    if(d.size==0){
      setState(() {
        isfollowing=false;
      });
      //isfollowing=false;
      // FirebaseFirestore.instance.collection("user").doc(widget.userModel?.uid).collection("following").doc(widget.model?.uid).set(professionalModel.toMap());
      //
    }
    else{
      setState(() {
        isfollowing=true;
      });
    }


  }
  @override
  void initState()  {
    super.initState();
    professionalModel= widget.model!;
    callmethod().whenComplete(() {
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    double? val = professionalModel.rating?.toDouble();
    return Scaffold(
      appBar:  AppBar(
        actions: [
          ProfileIcon(
              context,(){Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (context)=> ProfileScreen(userModel: widget.userModel,firebaseUser: widget.firebaseUser,) ));
          })
        ],
        title: InkWell(
          child: Text("Journal"),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyHomePage(userModel: widget.userModel,firebaseuser: widget.firebaseUser, title: 'RESET',)));
          },),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 50.0,fontWeight: FontWeight.bold),
        leading: const BackButton(color: Colors.black,),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(

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
              TextButton(
                  onPressed: () async{
                var data=FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("following").where(
                    "uid",isEqualTo: widget.model?.uid);
                var d=await data.get().then((value){
                  if(value.size==0){
                    setState(() {
                      isfollowing=true;
                    });
                    FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("following").doc(widget.model?.uid).set(professionalModel.toMap());
                  }
                  else{
                    setState(() {
                      isfollowing=false;
                    });
                    FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("following").doc(widget.model?.uid).delete();
                  }
                });
              //  print(isfollowing);
              }, child: isfollowing==false?Text("follow"):Text("following"),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){


                  }, icon: Icon(Icons.call,size: 40,)),
                  IconButton(onPressed: (){

                  }, icon: Icon(CupertinoIcons.chat_bubble,size: 40,))
                ],
              )


            ],
          )),
        ],
      ),
    );
  }
}
