import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reset/Models/Database.dart';
import 'package:reset/components/RoundedButtons.dart';

import 'AddTask.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key, this.taskModel, this.userModel, this.firebaseuser}) : super(key: key);
  final TaskModel? taskModel;
  final UserModel? userModel;
  final User? firebaseuser;

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {

  @override
  Widget build(BuildContext context) {
    TaskModel model = widget.taskModel!;
    return Scaffold(
      appBar: AppBar(
        title: Text("Task",style: TextStyle(color: Colors.black,fontSize: 50,fontWeight: FontWeight.bold),),
        leading: BackButton(color: Colors.black,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Text("Title: "+model.title!,style: TextStyle(fontSize: 30),),
                  SizedBox(height: 20,),
                  Text("Description: "+model.description!,style: TextStyle(fontSize: 30),),
                  SizedBox(height: 20,),
                  Text("Date: "+model.Date!,style: TextStyle(fontSize: 30),),
                  SizedBox(height: 20,),
                  Text("Duration: "+model.durb!.toString()+":"+model.dura!.toString(),style: TextStyle(fontSize: 30),),
                ]
            ),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.only(left: 88.0),
              child: RoundedButton(Colors.black, "Edit Task", () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddTask(day: DateTime.now(),userModel: widget.userModel,firebaseuser: widget.firebaseuser,taskModel: widget.taskModel,sentdata: true,)));
              }, Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
