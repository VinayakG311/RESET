import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Models/Database.dart';
import 'Journal.dart';





class book extends StatefulWidget {
  final UserModel? userModel;
  final User? firebaseUser;
  book({Key? key, this.userModel, this.firebaseUser}) : super(key: key);

  @override
  State<book> createState() => _bookState();
}

class _bookState extends State<book> {
  //String name = userModel?.firstname ?? "user";
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body:   SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(30, 50, 25,0),
              child: Row(children: [Text("Good Morning",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),)],),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 25,0),
              child: Row(children: [Text(widget.userModel?.firstname ?? "user"+" , I am Lia",style: TextStyle(fontSize: 30.0))],
            )),
            Row(
              children: [

                Padding(
                  padding: const EdgeInsets.fromLTRB(25,35, 5, 25),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                      children:[Image.asset('images/booksgirl.png',width: 150.0)]
                    ),

                ),


                Padding(
                  padding: const EdgeInsets.fromLTRB(25,35, 0, 25),

                  child: Column(
                      children:const [Text("How Are \nyou today?",style: TextStyle(fontSize: 30.0))]
                  ),

                ),

              ],
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25.0,5.0,25.0,10.0),
                    child: Image.asset("images/bookEmojis/Great.png",width: 75,),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Journal(val: 0,userModel: widget.userModel,firebaseUser: widget.firebaseUser,)));
                  },
                ),


                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25.0,5.0,25.0,10.0),
                    child: Image.asset("images/bookEmojis/Good.png",width: 75,),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Journal(val: 1,userModel: widget.userModel,firebaseUser: widget.firebaseUser,)));
                  },
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25.0,5.0,25.0,10.0),
                    child: Image.asset("images/bookEmojis/Ok.png",width: 75,),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Journal(val: 2,userModel: widget.userModel,firebaseUser: widget.firebaseUser,)));
                  },
                ),
              ],
            ),
            Row(

              children:const [Padding(
                padding: EdgeInsets.fromLTRB(35.0,0,40,0),
                child: Text("Great",style: TextStyle(fontSize: 20),),
              ),
                Padding(
                  padding: EdgeInsets.fromLTRB(35.0,0,40,0),
                  child: Text("Good",style: TextStyle(fontSize: 20),),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(45.0,0,40,0),
                  child: Text("Ok",style: TextStyle(fontSize: 20),),
                )]
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25.0,15.0,25.0,0.0),
                    child: Image.asset("images/bookEmojis/Bad.png",width: 75,),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Journal(val: 3,userModel: widget.userModel,firebaseUser: widget.firebaseUser,)));
                  },
                ),

                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25.0,15.0,25.0,0.0),
                    child: Image.asset("images/bookEmojis/Awful.png",width: 75,),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Journal(val: 4,userModel: widget.userModel,firebaseUser: widget.firebaseUser,)));
                  },
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25.0,15.0,25.0,0.0),
                    child: Image.asset("images/bookEmojis/Unsure.png",width: 75,),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Journal(val: 5,userModel: widget.userModel,firebaseUser: widget.firebaseUser,)));
                  },
                ),
              ],
            ),
            Row(

                children:const [Padding(
                  padding: EdgeInsets.fromLTRB(40.0,0,40,0),
                  child: Text("Bad",style: TextStyle(fontSize: 20),),
                ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(45.0,0,30,0),
                    child: Text("Awful",style: TextStyle(fontSize: 20),),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(35.0,0,40,0),
                    child: Text("Unsure",style: TextStyle(fontSize: 20),),
                  )]
            ),

          ],
        ),
      ),

      );

  }
}
