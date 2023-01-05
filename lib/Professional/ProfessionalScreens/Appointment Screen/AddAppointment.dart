import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Models/Database.dart';

class AddAppointment extends StatefulWidget {
  const AddAppointment({Key? key, this.model, this.firebaseUser}) : super(key: key);
  final ProfessionalModel? model;
  final User? firebaseUser;

  @override
  State<AddAppointment> createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  TextEditingController controller = TextEditingController();
  String time="";
  bool ispm=false;
  @override
  Widget build(BuildContext context) {
    controller.text="";

    return Scaffold(
      appBar: AppBar(leading: BackButton(color: Colors.black,),),
      body: Container(
        //  decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)))),
          height: 300,
          child: Column(
            children: [
              OutlinedButton(onPressed: () async{
                TimeOfDay? pickedTime =  await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context, //context of current state
                );

                if(pickedTime != null ){
                  DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());

                  String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                  String newtime=formattedTime;
                  if(int.parse(formattedTime.substring(0,2))>12){
                    int x =int.parse(formattedTime.substring(0,2));
                    String y = (x-12).toString();
                    newtime=y+formattedTime.substring(2);
                  }
                  else{
                    setState(() {
                      ispm=false;
                    });
                  }
                  setState(() {
                    time=newtime;
                    controller.text=time;
                    ispm=true;
                  });

                }else{
                }

              }, child: Text("Select slot")),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Text("time: ",style: TextStyle(fontSize: 20),),
                    Text(time,style: TextStyle(fontSize: 20),)
                  ],
                ),
              ),
              // showTimePicker(context: context, initialTime: initialTime)
            ],
          )),
    );
  }
}
