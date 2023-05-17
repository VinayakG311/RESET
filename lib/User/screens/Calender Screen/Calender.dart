import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reset/User/screens/Calender%20Screen/Tasks.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../Models/Database.dart';
import 'AddTask.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key, this.userModel, this.firebaseuser}) : super(key: key);
  final UserModel? userModel;
  final User? firebaseuser;
  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
 // CalendarFormat _calendarFormat = CalendarFormat.month;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 Padding(
                    padding: const EdgeInsets.fromLTRB(40,40,30.0,0),
                    child: Column(
                      children: [

                    SizedBox(
                    height: 340,
                      width: 300,
                      child: TableCalendar(
                        firstDay: DateTime(2020),
                        lastDay: DateTime(2024),
                        focusedDay:_focusedDay,
                        onPageChanged: (focusedDay){
                          _focusedDay=focusedDay;
                        },
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay; // update `_focusedDay` here as well
                          });

                        },

                      ),
                    ),

     ] ,

                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SizedBox(
                width: 120,
                height: 50,
                child: TextButton(style: OutlinedButton.styleFrom(shape: const StadiumBorder(),backgroundColor: (Colors.black),
                ),
                    onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddTask(userModel: widget.userModel,firebaseuser: widget.firebaseuser,day:_focusedDay,sentdata: false,)));
                    },
                    child: const Text("Add Task",style: TextStyle(color: Colors.white),)),
              ),
                const Padding(padding: EdgeInsets.all(25))],
            ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text("Tasks",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("tasks").where("Date",isEqualTo: _focusedDay.toString().split(" ")[0].toString()).snapshots(),
                    builder:(BuildContext context, AsyncSnapshot<dynamic> snapshot){
                    if(snapshot.connectionState==ConnectionState.active){
                      if(snapshot.hasData){
                        QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: datasnapshot.docs.length,
                            itemBuilder: (context,index){
                              TaskModel model = TaskModel.fromMap(datasnapshot.docs[index].data() as Map<String,dynamic>);
                              return InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Tasks(taskModel: model,userModel: widget.userModel,firebaseuser: widget.firebaseuser,)));
                                },
                                  child: Task(model: model,userModel: widget.userModel,firebaseuser: widget.firebaseuser,));
                            }


                        );


                      }
                      else{
                        return Container();
                      }

                    }
                    else{
                      return Container();
                    }
                    })


          ],
        ),
      ),
    );
  }


}

class Task extends StatefulWidget {
  const Task({
    Key? key,
    required this.model, this.userModel, this.firebaseuser,
  }) : super(key: key);

  final TaskModel model;
  final UserModel? userModel;
  final User? firebaseuser;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool isdone=false;
  @override
  Widget build(BuildContext context) {


    return Padding(
      padding:  const EdgeInsets.only(left: 18.0,top: 8,bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(value: isdone,
                  onChanged: (bool? value){
                setState(() {
                  isdone=value!;
                });

              }),
              isdone==false?Text(widget.model.title!):Text(widget.model.title!,style: const TextStyle(decoration: TextDecoration.lineThrough),),


            ],
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: InkWell(
              child: const Icon(Icons.delete),
              onTap: (){
                FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("tasks").doc(widget.model.uid).delete();
              },
            ),
          )
        ],
      ),
    );
  }
}

