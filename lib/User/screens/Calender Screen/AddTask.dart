import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../Models/Database.dart';
import '../../../components/Widgets.dart';
import '../../../pag1-method2.dart';
import '../Profile Screen user/Profile screen.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key, this.userModel, this.firebaseuser, required this.day}) : super(key: key);
  final UserModel? userModel;
  final User? firebaseuser;
  final DateTime day;
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController controller1= TextEditingController();
  TextEditingController controller2= TextEditingController();
  TextEditingController controller3= TextEditingController();
  int a=0;
  double b=0;
  bool y=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          actions: [
            ProfileIcon(
                context,(){Navigator.of(context)
                .push(MaterialPageRoute(
                builder: (context)=> ProfileScreen(userModel: widget.userModel,firebaseUser: widget.firebaseuser,) ));
            })
          ],
          title: InkWell(
            child: const Text("Calender"),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyHomePage(userModel: widget.userModel,firebaseuser: widget.firebaseuser, title: 'RESET',)));
            },),
          titleTextStyle: const TextStyle(color: Colors.black,fontSize: 50.0,fontWeight: FontWeight.bold),
          leading: const BackButton(color: Colors.black,),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Add Task",style: TextStyle(fontSize: 50),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(
              children: [
                const Text("Date:",style: TextStyle(fontSize: 20),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.day.toString().split(" ")[0],style: const TextStyle(fontSize: 20)),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 18.0),
            child: Text("Task Title:",style: TextStyle(fontSize: 20),),
          ),
          Padding(
            padding: const EdgeInsets.only(left:18.0,right:18.0),
            child: TextField(
              controller: controller3,
              decoration: const InputDecoration(
                  hintText: "Enter Task title",
                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black))),
              maxLines: 1,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 18.0),
            child: Text("Task Description:",style: TextStyle(fontSize: 20),),
          ),
          Padding(
            padding: const EdgeInsets.only(left:18.0,right:18.0),
            child: TextField(
              controller: controller1,
              decoration: const InputDecoration(
                hintText: "Enter Task description",
                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black))),
              maxLines: 1,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 18.0),
            child: Text("Task Duration(in mins):",style: TextStyle(fontSize: 20),),
          ),
          Padding(
            padding: const EdgeInsets.only(left:18.0,right:18.0),
            child: TextField(
              controller: controller2,
              onChanged: (value){

                setState(() {
                  if(value!=""){
                  int val = int.parse(value);
                  a=val%60;
                  b=(val/60);
                  }
                  else{
                    a=0;
                    b=0;
                  }
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "Enter Task duraton",
                  border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black))),
              maxLines: 1,
            ),
          ),
          Stack(
            children: [
              Image.asset("images/timer.png"),
              Padding(
                padding: const EdgeInsets.only(top: 130.0),
                child: Center(child: Text(b.toString().split(".")[0]+":"+a.toString()
                  ,style: const TextStyle(fontSize: 50),)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 290.0,left: 95),
                child: RoundedButton(Colors.black, "Create",
                        () { showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            content: const Text('Task Created',style: TextStyle(fontSize: 25),),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'OK');

                                  setState(() {
                                    y=true;
                                  });
                                //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Calender(userModel: widget.userModel,firebaseuser: widget.firebaseuser,)));
                                  },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                //  if(y){
                        int m = b.toInt();
                        TaskModel taskmodel = TaskModel(const Uuid().v1(), controller1.text, controller3.text, a, m);
                        FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("tasks").doc(taskmodel.uid).set(taskmodel.toMap());
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage(title:"RESET",userModel: widget.userModel,firebaseuser: widget.firebaseuser,)));
                //  }

                  },
                    Colors.white),
              )

            ],
          ),

          // RoundedButton(Colors.black, "Create", () { }, Colors.white),
        ],
      ),
    );
  }
}
